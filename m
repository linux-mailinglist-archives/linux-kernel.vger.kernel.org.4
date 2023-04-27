Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0B6F0651
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbjD0NE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbjD0NEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:04:54 -0400
X-Greylist: delayed 662 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 06:04:50 PDT
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3972D72
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682600686; bh=9eIpaK6qsbATrucAS3D9t6aE9hGbGWJhmkVCEJk7Msg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=N4s1H+R3pYgmxPaP7B6FHorD1nyJfR5F/9dnnxSlA7z1UTlbwrKJ57qHsHoEQryba
         1QFHOl1YgCE+vT8L5DbZwx2K4nPmHCRLPA53Dgv6xRKrLOmjRE8uYONjPeEuYw56yq
         A/5li2tzbSJiSHaGxct/VlsuXPXdO2FNFF9/u8eI=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id BD4A5CA0; Thu, 27 Apr 2023 20:47:20 +0800
X-QQ-mid: xmsmtpt1682599640t519ijgnm
Message-ID: <tencent_BC64BBD18CAF41904B9BD1510B1739062805@qq.com>
X-QQ-XMAILINFO: NJ/+omVLhVgasM8xrCwXqQLqxdfhOSMWAGMHYCh5/DRfXhjvY/sQ6rAgga8Kq1
         e4Ng5wa1JQBXAFEgCvi8ESAnxyhDm7n293s4emhIlkUHGLfigrzv7rB2SNYNWFP8eMq2JbtxzUJt
         WYSVkiAiy8lw9FgzIEHDF0WxsltFJ4NSBmbP9jN2XYcbW2dopnV9mOSxG9FcZcuM8n9jVrrmnL8/
         ENOXFKlbCqfTWj0cqlyTvLKLR0JlhewOjfyFvyEXa6nFhTdKkwAxSC01rRnz2jOM1/2zGSzRO8fR
         CaiN/zgaLNxwW3Ax+rsMcuKp7HtzbCKgnmbD7U6U4e7GpyjMUsx/j/jpmGXDSKQm9VEs8ynR+VxC
         uWdlmKw2Xw5FrYOcOG2tYCu+sMmO0mnOMfLNL/o5ot02B5AkloCOFn9MoIb95q6zKUbFAvS3jn41
         CbD8cwVpaG3g+bEu47S0Gshkb6FYrOa+K7Q+wXXKMjwWTobtK6poOBWpHELqfJm4OppdrUM3mHZP
         8HL82EUbXxBFi8GZLpxEi8i83pVmd4ScQuYz7CxpppKRxB1QNFL3+xQoMHUPnGaeCE75BLKDGJkU
         +qxoKhfVr2PjmyIE/anieLwxFu9ZloMB1DMvfIao1vebRxxfJCQ3wuoxEE2m/j9Zg/azlIqHYvGd
         hRI4xNg6tXisFw4A979DxfEZiN31J3bpp6M2wesdhDSFBr6YmpOeBiC5tZUF85QDVUijWjyRFhya
         G+9Iynryne5GLrvOdrsjlWJm03tZtOnYfRzsGn7RIlEjjryo3ZyhpjBNkXcb2+rUlML2gHV+OtO1
         FY66QYbYk9bfieost2wl+SNugHcFYfDgU6/lsAJrQYKTnpsNlI+1Mg6LgYh0qR3sg7YqvjkoAymU
         lyfSoMNQFmFO3isKQCVwh+tgkLtZmTJ11qGgp4I7QGrY8jM8jS9as8lSf0j+hCI0FpXd+sFnzGHg
         dg83r41vCxHcJ8Yi7Lo9l7jgWKaqs4ssHfUUu7UCm25FhGEqtV4gDqZugPwXn2kpUgJTDle6c=
From:   Yangyu Chen <cyy@cyyself.name>
To:     conor@kernel.org
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu, cyy@cyyself.name,
        i@zenithal.me, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, soha@lohu.info, twd2.me@gmail.com
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Date:   Thu, 27 Apr 2023 20:47:18 +0800
X-OQ-MSGID: <20230427124718.239569-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426-porthole-wronged-d5a6a3b89596@spud>
References: <20230426-porthole-wronged-d5a6a3b89596@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor

Thanks for your meaningful reviews. I agree with most of your advice but
have a question about the code about checking the first 2 characters are
"rv" in `arch/riscv/kernel/cpu.c`.

On Wed, 26 Apr 2023 19:54:39 +0100, Conor Dooley wrote:
> > @@ -41,7 +42,7 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
> >  		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
> >  		return -ENODEV;
> >  	}
> > -	if (isa[0] != 'r' || isa[1] != 'v') {
> > +	if (tolower(isa[0]) != 'r' || tolower(isa[1]) != 'v') {
> >  		pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
> >  		return -ENODEV;
> 
> I don't understand why this is even here in the first place. I'd be
> inclined to advocate for it's entire removal. Checking *only* that there
> is an "rv" in that string seems pointless to me. If you're on a 64-bit
> kernel and the node has riscv,isa = "rv32ima" it's gonna say it is okay?
> Drew what do you think?

I think this code could be a workaround for running rv32 S-Mode on rv64
CPU without changing the DT, although the proper way should be to change
this field in DT by bootloader or any other software.

I have tested a simple rv64imac CPU core and left the `riscv,isa` string
empty in the DT and removed the above 3 lines check from the kernel, and
the kernel boots successfully, and using busybox as init is also ok. 
However, if this check exists, the kernel will panic at `setup_smp` due to
`BUG_ON(!found_boot_cpu)` in `setup_smp`.

I am wondering whether this should remove or add a more sufficient
validation. Although this function will not be called in ACPI as I
reviewed the recent ACPI patches[1], it will not be a problem if I submit
this patch for better ACPI support. However, If I just simply remove it
from my patch and submit patch v2 directly, the ISA string in ACPI mode
with all uppercase letters will be OK. But in DT mode, the kernel behavior
will accept the ISA string with all uppercase letters except the first two
"rv". Do you think this behavior is different between DT and ACPI can be
OK?

After some investigation, I suggest removing this validation since the
validation is useless for a proper DT and the recent ACPI patches[1] do
not validate the ISA strings, so we will have the same behavior between
DT and ACPI.

[1] https://lore.kernel.org/linux-riscv/20230404182037.863533-1-sunilvl@ventanamicro.com/

Thanks,
Yangyu Chen

