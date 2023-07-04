Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B3747427
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGDOby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjGDObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:31:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF6E47
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:31:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 358AC5C022A;
        Tue,  4 Jul 2023 10:31:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Jul 2023 10:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688481107; x=1688567507; bh=aqNsrJHVCnGS5M3xoGiJRBSxbIqtfC2tngp
        dKmlsVZU=; b=RI/bfPN9cjPntRtrW/Dbhv9tP8VrrltI/MZdGagrm86vvoc0yef
        NROG9VgHWAWe8NcWA0/rNzns3UCg72E4fB1KVUpbDy5OXb8AEMYx2rTC59zR2ERz
        A+uaYnleg/oE9VVFjEBaX2szm5bvkYdnYZTQPYbhEi8f/E4IVGN75SBz82tAQkSs
        7pisihqSoBEZsKqTVHzm3yXOrIDLpYElPq1outbbZ8JpbBMggoYg3nsA/aN0GEWB
        CR4qj9XPh6CbKSz3o9bg8YFBrZay3g871CZV8ZO0IRqtq3imdDxjLmtZgII+MxMi
        LaMa/jHTqZYh4cvXDdghsGnkFZtA6mppE9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688481107; x=1688567507; bh=aqNsrJHVCnGS5M3xoGiJRBSxbIqtfC2tngp
        dKmlsVZU=; b=BhdV1iWlRIff/+xmjml84Pc86sgHA5/c+T5LXLSssMgArI8+Icn
        0Ae0+dk9C0Va5vfQ5+jOVeHh0qOmIVcJl6DWBRWNbBgSyTlMrPV578a6YSNnRaOl
        72B+E3R+icS3raoq2yuuuwoYLf2Tu3/Vs2qU92ta7WZVt8Gb1t+GAqYf/PYoypfG
        Vx7VKIc91RCJsFJcRcptvsPSSOQ9+xIU4qRAm7fd0gtUVv3Iwc5f0zExjrlh2ulx
        J2DHGmtxjDRub9f5FyrNK8RLfcsKflgDFEtnMvfJ+JmRdcTVHKj3rYIBjbK0cT7D
        DDTHF7eDTuYmg4d6I180VCWH2hjlj7ShjpA==
X-ME-Sender: <xms:Ui2kZK_1c2_n9pzTTo159TkOPurTHtgChsVx8aJD-eEg3BtGspCgrg>
    <xme:Ui2kZKvxZCobXlWGuYVd7UgFUlXL_GBLc1roQekMrWi3IfSEXkDgWFaaFu0ep4ebO
    LFW8HKexD0VI6mLNaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Ui2kZADgHsmy1cqQ5nP4hf74j7eG8GWrvM_I7laOXOVNWJReo1WaAg>
    <xmx:Ui2kZCfMSCTn1lTPz5DwFSqwDoZMEmV_luDH77WrUdru9YiEs0faKg>
    <xmx:Ui2kZPO6oRx3VYRPIOhgxIcC-HZjzfMMUYvU_XAZjdbP0mgaSIrbZw>
    <xmx:Uy2kZGnyBsK_4CgKkxnKRlzGWU-sEmSj3XnCwzNaJqWE-0mi7fXQUg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 525ACB60089; Tue,  4 Jul 2023 10:31:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <9b03246d-b46e-4b91-968a-e9ffc2fc26db@app.fastmail.com>
In-Reply-To: <f1b190cb-3af7-178b-baeb-b59363868779@amd.com>
References: <20230703123557.3355657-1-arnd@kernel.org>
 <f4bc3739-3ff1-6fa7-5d7d-890f451315bf@amd.com>
 <788147c6-defd-496a-8174-1571b73d1a71@app.fastmail.com>
 <f1b190cb-3af7-178b-baeb-b59363868779@amd.com>
Date:   Tue, 04 Jul 2023 16:31:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>
Cc:     "Hawking Zhang" <Hawking.Zhang@amd.com>,
        "Lijo Lazar" <lijo.lazar@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "YiPeng Chai" <YiPeng.Chai@amd.com>, "Le Ma" <le.ma@amd.com>,
        "Bokun Zhang" <Bokun.Zhang@amd.com>,
        "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>,
        "Shiwu Zhang" <shiwu.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: avoid integer overflow warning in
 amdgpu_device_resize_fb_bar()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023, at 14:33, Christian K=C3=B6nig wrote:
> Am 04.07.23 um 14:24 schrieb Arnd Bergmann:
>> On Tue, Jul 4, 2023, at 08:54, Christian K=C3=B6nig wrote:
>>> Am 03.07.23 um 14:35 schrieb Arnd Bergmann:
>> Not sure I understand the specific requirement. Do you mean the entire
>> amdgpu driver requires 64-bit BAR addressing, or just the bits that
>> resize the BARs?
>
> Well a bit of both.
>
> Modern AMD GPUs have 16GiB of local memory (VRAM), making those=20
> accessible to a CPU which can only handle 32bit addresses by resizing=20
> the BAR is impossible to begin with.
>
> But going a step further even without resizing it is pretty hard to ge=
t=20
> that hardware working on such an architecture.

I'd still like to understand this part better, as we have a lot of
arm64 chips with somewhat flawed PCIe implementations, often with
a tiny 64-bit memory space, but otherwise probably capable of
using a GPU.

What exactly do you expect to happen here?

a) Use only part of the VRAM but otherwise work as expected
b) Access all of the VRAM, but at a performance cost for
   bank switching?
c) Require kernel changes to make a) or b) work, otherwise
   fail to load
d) have no chance of working even with driver changes

>>> It might be cleaner to just not build the whole driver on such syste=
ms
>>> or at least leave out this function.
>> How about this version? This also addresses the build failure, but
>> I don't know if this makes any sense:
>>
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1325,6 +1325,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_d=
evice *adev)
>>          u16 cmd;
>>          int r;
>>  =20
>> +       if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
>> +               return 0;
>> +
>
> Yes, if that suppresses the warning as well then that makes perfect=20
> sense to me.

Ok, I'll send that as a v2 then.

    Arnd
