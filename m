Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201315E54D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIUU70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiIUU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:59:23 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE9A5724
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:59:19 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 5362 invoked from network); 21 Sep 2022 22:59:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1663793956; bh=a71HTrKjSyPR9ycQG2ZSn218u6d2jMS73uaEWKrlMrg=;
          h=From:To:Cc:Subject;
          b=JWQ+a4eAI4HqRBXZUYN+UCm8E2LqDl7VtuBj7CPbW2RQtEE1LOBnWmonrfztKWW/h
           P78z4oezQi9eV2gSyc4EgS/6xXwCTj9evkxdua7TvOiNHZCTKOrYMRa6y3oKMWNV6x
           skGZ17QrbpufqoAe7OyVsK9sH6Tg8v3KqnnW4t4Q=
Received: from ip-137-21.ds.pw.edu.pl (HELO LAPTOP-OLEK.lan) (olek2@wp.pl@[194.29.137.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <john@phrozen.org>; 21 Sep 2022 22:59:16 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     john@phrozen.org, martin.blumenstingl@googlemail.com,
        hauke@hauke-m.de, tsbogend@alpha.franken.de, maz@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH v2 0/1] MIPS: lantiq: enable all hardware interrupts on second VPE
Date:   Wed, 21 Sep 2022 22:59:43 +0200
Message-Id: <20220921205944.466745-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 504adcc00ef8e39b5c85d436a1f10740
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [MVN0]                               
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 - switched to upstream recommendation.

Aleksander Jan Bajkowski (1):
  MIPS: lantiq: enable all hardware interrupts on second VPE

 arch/mips/lantiq/prom.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.30.2

