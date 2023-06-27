Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF373F44A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjF0GNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0GNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:13:48 -0400
Received: from ultron (136.red-2-136-200.staticip.rima-tde.net [2.136.200.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C87FF10DA;
        Mon, 26 Jun 2023 23:13:46 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ultron (Postfix) with ESMTP id F0BC51AC21D7;
        Tue, 27 Jun 2023 08:13:44 +0200 (CEST)
From:   carlos.fernandez@technica-engineering.de
To:     carlos.fernandez@technica-engineering.de, sd@queasysnail.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Date:   Tue, 27 Jun 2023 08:13:44 +0200
Message-Id: <20230627061344.25078-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ZJW87b0ijjBytbqB@hog>
References: <ZJW87b0ijjBytbqB@hog>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,SPF_FAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sabrina, 

Your proposal seems good and fills all the possible alternatives. 
We'll prepare a new patch following your recomendations and send it again.

Thanks
--
Carlos
