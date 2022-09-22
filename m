Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40A5E658B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIVO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:29:37 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D172AE7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:29:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 49BE944C65;
        Thu, 22 Sep 2022 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1663856972; bh=uspIl9LGe96i3dV8zEjsYdGYA7mcTRqfeZXjm1Wudnc=;
        h=Date:To:Cc:From:Subject;
        b=egSgGta2kLf3JeKvnzk7n65+B2MVdyVOo2U1UZVRvGFf1r0XMLyJHrgHxJZ69LaL8
         Tf9yeLmmqovT0PeiHiQ9DmVjD6yEjBzEcTQKXId16A12+Ttw/4bGIaS7IvD41u1uxO
         XhPxGPIe1C8O5zyXfhzf9XsVo2BbtxkcCfpcecf3zd6iqBMoYMI91NOiAOJevObjSZ
         o6OIUZcl5VMwrWeiP8Ge+oYumyjgmSF8UPONSY33X3nFtiFqIrn6zGyatnidJ6S0YQ
         dfdJnQ1n2eTg7VByKTexVMc+U4PSgw0oTzAie7CkqVtOEEecoKkdi5nuHXOCGVmWMN
         CkWLLLe+f43IQ==
Message-ID: <2159b672-4db7-5add-8046-ed5354dd5343@marcan.st>
Date:   Thu, 22 Sep 2022 23:29:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: es-ES
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Please add asahi-soc to linux-next
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

Hi Stephen,

Could you add the asahi-soc trees to linux-next? We are downstream from
SoC and would benefit from testing in linux-next before I send out PRs.

URLs:
https://github.com/AsahiLinux/linux.git asahi-soc/fixes
https://github.com/AsahiLinux/linux.git asahi-soc/for-next

(Right now we have no fixes, and some DT changes in for-next)

Thanks!

- Hector
