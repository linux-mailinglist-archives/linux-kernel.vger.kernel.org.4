Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B636F1C91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346116AbjD1Q1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbjD1Q1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:27:16 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A651A2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682699227; bh=JhuCoJUmtEAdSf+MR1nkkhEmccdfmanyUVUZ3X+cz58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=A+6nKzIafz5AMmejiR3Jkep0DzhpaHd66dCMUncHmcc4YFOPS0At67/Tf1wP+M0t2
         ZyVUbP0voZNlz4VBHoq67xeP85+3EFK7YOWsd7CaagTtG5aqg+Zj6KtIWhlw7txgXA
         bVwoCeZnAuA+HlZEFJyUaqUKtVrG0WUfjzzxt6cw=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 6A59F66C; Sat, 29 Apr 2023 00:26:37 +0800
X-QQ-mid: xmsmtpt1682699197tk5ydnq37
Message-ID: <tencent_D5671CCB7149630242B61A1BF8B80581B409@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujnNRNhosd+ozTQu7JOlNjmcU8foYoOa6977Axo9aJzWhAdVrhJD
         whJ65NIlWJrfVidUKkJATDxyFqe5chnPG7K7HKgtop8xRYFVps8lymtRonU9OfLKhieVECtJ5uSp
         Xg0BrBxzi9V/osr1rnNaLarJZ5gviUyDmP5YAqR5IQpm88Xy1YVMRAq8PoGdYuz7Ey/wjetAPYyu
         Wxk+c644t5CY3ut1iiG0y0R4IiUkJqfkvCuvoVdx8B93hEblvGSStOnlbucj1RjNxdu3l34J3396
         1P61efPSIZue6HtjMWFnQOC8m/pUJEGx64DAj+I442RVZETh6nbyon0xVF2kWM9GRMzP8DUCIJKU
         +FyvE3nvJJwqYyFQPLGM8pwNyVYYYAV16sFsgTL68zdcCYiO0/zZD1acos5wQxZ4TrVKculL1x5h
         njCNiMAjkmns2b7c81q9z+xXcD5YM8QMzUU2bZWa7AMRZgt/LEX4P+MgXVnCavyGYjQ16VTOfwLL
         z+9KlNPQnOzFBizlpdX55X70hQfDCiivp9W0ZLzZ85MmsnoclFpkg1jd/UPPhosqWZMIB9couQIr
         pTFUaAsKQiHZXECYftNzjox436CeB6lERfh44HLHcNPiB5vBWxsfP7jhKtQ8tnan7Vny3dF6qdWe
         GsTiEYK8dOKn4zTyL2lyeSRsKMK7U9JiHFma+/ipfnolMXyZ0nLBiJTNWyF/wQVFOajpx0Z/bWax
         VS5jdJlBPK7wlZNq9miYhdOFOrZi/hghn2tBF+sTuhhbEdSNqseyStQB/T9tQIIPY6elsZaAauXW
         aF/HykjWogFhqgm8svgyWYWOtQ+gKUOIl62jgKR3sXyNTFVlhnlvk9Tht7KwPqpW4HaqqDTzSXTo
         JNeGu7SS13FnTaVemwPAnSmZCfmVwd7MCMFEGoIvdGM/3wOWwIls8cfEmzkZSk4NH9jpDP+qyJXG
         YUrB8dRj19TDL7Ma7G7N45I2t5FUhwwwYThFaWI0HZX7YF8I91P3I09m52HH2Lzc1ryuJwFIM=
From:   Yangyu Chen <cyy@cyyself.name>
To:     cyy@cyyself.name
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu, conor@kernel.org,
        i@zenithal.me, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        soha@lohu.info, twd2.me@gmail.com
Subject: Re: [PATCH v2 0/2] riscv: allow case-insensitive ISA string parsing
Date:   Sat, 29 Apr 2023 00:26:00 +0800
X-OQ-MSGID: <20230428162600.698947-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
References: <tencent_BC90DDC6093E3E41246D3EC73F5CAB189007@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the cover letter being detached with patches. My mailing
service provider will override the Message-IDs which caused this 
trouble. I will send the cover letter first to get the correct Message-ID
before sending the rest of the patches the next time.

The cover letter is at https://lore.kernel.org/linux-riscv/tencent_8492B68063042E768C758871A3171FBD2006@qq.com/
The patches is at https://lore.kernel.org/linux-riscv/tencent_85F69423082E524C478844E31D5F8920A506@qq.com/

