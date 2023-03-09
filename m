Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D346B2F65
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCIVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCIVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:15:36 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C9EBF95;
        Thu,  9 Mar 2023 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ixIrPmQY5V3ydK/qcTT2lhGMIZiKhgfdUtuSNlZQNnI=; b=O/ak1RGDiUGpm1ORbfPQOh7PgF
        eE3XE+TdC16op6Yh5afnMTtzVjUJtcwCgH2iglsI6dZVXErEy21B9b+hGbjsEsmnsfGoOwLEPN7uk
        26AoZGLPOKxhSi/dOioUYNLupJ/rLK4SiSSvvCO5IvD+ulk8BwAuzRujEchk3qs5vX01f40ZxnL2b
        eWrYba85XN2wr4HcBgKqrMx4Gk1F/BsMGiWs6t0C94WzaVdcnB0LBz21CEuUm5VWL4KVD9KW0dRB3
        8dv9b0qaYORfSn65Pzy/YuQLlDEmnOSTsfAWz1QDO0jYWlVSTCcnKAD63sVSWL2fW3qe9EBT4FDs9
        nLZP3hIA==;
Received: from 201-68-164-191.dsl.telesp.net.br ([201.68.164.191] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1paNbl-0025wK-R0; Thu, 09 Mar 2023 22:15:29 +0100
Message-ID: <a10e1319-b631-6d3b-5e1d-b07223350502@igalia.com>
Date:   Thu, 9 Mar 2023 18:15:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org
Cc:     nathan@kernel.org, rasmus.villemoes@prevas.dk,
        Nick Desaulniers <ndesaulniers@google.com>, nicolas@fjasle.eu,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>, gpiccoli@igalia.com
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: About the .scmversion removal (commit f6e09b07cc12)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro / all, I was rebuilding the kernel today, just adding some
debug statements, when I noticed a lot of stuff got built again. I was
using ".scmversion" to prevent UTS version changes, so only affected
files got indeed rebuilt.

After commit f6e09b07cc12 ("kbuild: do not put .scmversion into the
source tarball"), seems this file is automatically deleted and I'm not
sure how should I proceed to continue with the same behavior.

Apologies if this is a silly question, any advice is much appreciated!
Also, I've CCed all the emails from [0], so apologies if anybody looped
here shouldn't be CCed.

Cheers,


Guilherme


[0]
https://lore.kernel.org/lkml/20230122141428.115372-1-masahiroy@kernel.org/
