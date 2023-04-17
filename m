Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BFE6E4E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDQQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDQQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:18:45 -0400
Received: from harvie.cz (harvie.cz [77.87.242.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94DC04ECE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:18:44 -0700 (PDT)
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by harvie.cz (Postfix) with ESMTPSA id C72A61802BA;
        Mon, 17 Apr 2023 18:18:41 +0200 (CEST)
From:   Tomas Mudrunka <tomas.mudrunka@gmail.com>
To:     danielwa@cisco.com
Cc:     akpm@linux-foundation.org, christophe.leroy@c-s.fr,
        dwalker@fifo99.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maksym.kokhan@globallogic.com,
        mpe@ellerman.id.au, robh+dt@kernel.org,
        xe-linux-external@cisco.com,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>
Subject: Re: [PATCH 1/4] add generic builtin command line
Date:   Mon, 17 Apr 2023 18:18:18 +0200
Message-Id: <20230417161818.2002082-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20190319232448.45964-2-danielwa@cisco.com>
References: <20190319232448.45964-2-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems quite useful. Can you please merge it?
