Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D35E6E1DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDNISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDNISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:18:33 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467306E9D;
        Fri, 14 Apr 2023 01:18:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A90265C00E8;
        Fri, 14 Apr 2023 04:18:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Apr 2023 04:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1681460311; x=1681546711; bh=Bc0pT2daBTU9tVgFjZ8Ba3dqY4qyOA04fQh
        gM2l2eck=; b=UxPbbZFZwOBd9G2Nxjg0ul2HGzohc3CtWd60kgtEw93f7Ooww5z
        DU8hkhNApz6JC8OAohmolLCjzWWiLhdazwsHxov+0TRcJukOaiSKmxeAxanV3+nb
        eA/A14OGsct1z7YQ7Ij0GmJ9a6MeSqtxvPsQIOgTzV2NTz5cnReyRHoe8/HUT5xy
        Xj/Cgy+XMymv8PD0JI+WBVzkkZsjKd7Gds29XYR6XPhnceI4y1mWgS64i4gc3zGa
        TFifDLX7OzXUjE8ynPXGFWGIFl45rVZLTn1rFzGe8GuRDsdNDhxWCL/k8T+wIr/e
        xbVvo0JxXVDPRVOQ6Z4jr0maYILMMZsyO+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681460311; x=1681546711; bh=Bc0pT2daBTU9tVgFjZ8Ba3dqY4qyOA04fQh
        gM2l2eck=; b=XBrs8KQXClKUt0VBUb54mfl0+mdP8/SqOwjqIgFuG9aLTZbVYv/
        3J6dzYnk4Vt61Sz+4JYdi2kqeRCl5jnOywzmcRqwBUwBd9DzjODfFB1vdYZtWBpg
        QAFhED1VLbCIeY0mx6BW2v2MnvCnl+g8Awk+DBtasLmMVKrKBiqGW9rt3vY9HYjs
        Kz3aDoJelEjwq4GSH7M8jtuuaoTW6Et1iuUn3noMn6/cX/S0J6z1j6X7FqrAKh3r
        VjKfE0wm8vAEGJ7Q0ef5ybuDbEwQQ/dzCSfKo2RvElEfRTy9zaLxhqFupfY0GamV
        UgjKlOBZHVSdPLm+jlGXxGASqeB/77RMyVA==
X-ME-Sender: <xms:Vww5ZLRyYSSkS3fJB89LAU4DAs27fMmAG1eSeLm6vX9c8v51zyGKbw>
    <xme:Vww5ZMyqcSiHxb1NwrBzLVcYE4iCHzSuNZgdd6VVxoLRH9hjiO_GLnlz53o_49Rqu
    hvmU-ZQ0yPrpAPl9Kk>
X-ME-Received: <xmr:Vww5ZA1ZSaveJSoSygjHCXctrjnRETXnepPtLaFIDJKBSZIlhd8BvrtD8PYcMhqEbiEi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesth
    hqmhdthhdtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedutdejffetteefke
    ejieehfeeuieeguedtveeijeeviefhffelvdfgudeihfdvtdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Vww5ZLAEHHcYHlPzPNXJ8APeejk_q0FpzHphp9jyhZ-YN8fyoLjYZw>
    <xmx:Vww5ZEjjpxFwUr_2_3a0aIpZ-c27M_mQpWWtu_0AqKcxjkmunlrPPA>
    <xmx:Vww5ZPoR9dGfR8V-MEErPJGzPjem-cYayX-BQu3pzsJpxLe2pghJQw>
    <xmx:Vww5ZAb2TNq6v7iqJit4xmuA-GRfUsgWA_L6haR-WVV7inRK_A6-DQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 04:18:30 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Multiple undefined configuration options are dependent in Kconfig
 under the v6.3-rc4 drivers directory
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230410232725.zwbccyryboxj3bh5@mobilestation>
Date:   Fri, 14 Apr 2023 09:18:20 +0100
Cc:     linux-kernel@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <011B19A8-1276-4603-B4D8-4CA7E9F07B3D@flygoat.com>
References: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
 <18c3fbb4-59db-d508-ddd6-080cc8944b39@opensource.wdc.com>
 <20230410232725.zwbccyryboxj3bh5@mobilestation>
To:     Serge Semin <fancer.lancer@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8811=E6=97=A5 00:40=EF=BC=8CSerge Semin =
<fancer.lancer@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Mar 30, 2023 at 07:34:58AM +0900, Damien Le Moal wrote:
>> On 3/29/23 16:52, =E5=AD=99=E6=BB=A2 wrote:
>>> It has been discovered that the following configuration options are =
undefined in the current latest version, v6.3-rc4, yet they are being =
relied upon by other configuration options in multiple Kconfig files:
>>>=20
>>> MIPS_BAIKAL_T1 is undefined, used as a 'depends on' condition in =
multiple files such as drivers/ata/Kconfig, drivers/hwmon/Kconfig, =
drivers/bus/Kconfig, and drivers/memory/Kconfig.
>>> MFD_MAX597X is undefined, used as a 'depends on' condition in =
Kconfig file drivers/regulator/Kconfig.
>>> MFD_SM5703 is undefined, used as a 'depends on' condition in Kconfig =
file drivers/regulator/Kconfig.
>>> ARCH_THUNDERBAY is undefined, used as a 'depends on' condition in =
Kconfig files drivers/pinctrl/Kconfig and drivers/phy/intel/Kconfig.
>>> ARCH_BCM4908 is undefined, used as a 'depends on' condition in =
Kconfig file drivers/leds/blink/Kconfig.
>>> MFD_TN48M_CPLD is undefined, used as a 'depends on' condition in =
Kconfig files drivers/gpio/Kconfig and drivers/reset/Kconfig.=20
>>> USB_HSIC_USB3613 is undefined, used as a 'depends on' condition in =
drivers/staging/greybus/Kconfig and =
drivers/staging/greybus/arche-platform.c.
>=20
> Please, don't drop the MIPS_BAIKAL_T1 config. It will be defined and
> thus utilized after I submit the SoC CSP support to the MIPS arch.

Hi Serge,

Is there any special support at MIPS arch level required by Baikal T1?

I think MIPS32R5 generic kernel should fit your purpose? You can easily =
add some =E2=80=9Cworkaround=E2=80=9D
under generic kernel framework as well.

Thanks
Jiaxun




