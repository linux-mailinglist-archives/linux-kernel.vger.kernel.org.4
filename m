Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8933474714A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGDM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGDM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:27:06 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B75010D0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:26:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B5DCF5C035D;
        Tue,  4 Jul 2023 08:26:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Jul 2023 08:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688473592; x=1688559992; bh=PyQ6plTYSpz3qzON9fE4kLUBzehylHzFdDq
        XyOgLcvE=; b=W77S1TQLBvy4PGVojukXY3qROfvcIqKfpp/nBKGH7ekWnnc3mac
        GXslhBK60I6NKAMd8sOg2loMZJyYKa5TDtel7hJQv16/1Ue9uuR3oZT5ypG3IoZO
        Q9s9N44TMrGD/mvjXafzgFrFHimoi/WYU7i3cEnqN5qp6FA0oiAiK4khkbzpNdjk
        7tBQ0e2YlV9aGPRlu1OOfvqE54RRqNIdvE7d4V716wCqwjeidPYnXlZM7eZFLXfD
        pua2W+yosiXEx9NkeljVm+f8spE1HBI2XL/aJa5h1PoGxwifAiGCZ7NlxwGHekUu
        mQEjtn+YvQCHl4B7DOOhPWv7aGBeDTaiZEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688473592; x=1688559992; bh=PyQ6plTYSpz3qzON9fE4kLUBzehylHzFdDq
        XyOgLcvE=; b=IPocYXY7TnafTvok9h1lETy4GCn/FhjYgMijmoCjvkOE3UfIZTk
        UiSNhMXXS3BigYlIwW6RIFE1CpOEphaB1sStCz8s20dG3gRzbZg6UYPdOFi2rAnm
        0Z0mTeJ7zZgj/SKuZbMOA509ImEpZ73TE+W66RENpRF6g0hRInbaoXaCVejO1EY9
        Nw/c2JK+j0yyNyPFEpFx0f2hKv+d6ASTfvg6AduwmwzZ41oG/hN+rXTe58SVvO3q
        svEEAdmR2ON6GaX0y5KkawBi4XdgYS0BT8pGOytMZXdZN0OQaDtUH80Wzjo6CDGh
        aT5J94WDzrb0Jmr0NU1KEzo3LNND+hZxUTw==
X-ME-Sender: <xms:-A-kZAGiH5z4tS9ps_N9F_yGho1DcFLpTElwHhvdo51Y3EHTQaVt6Q>
    <xme:-A-kZJX85mPqrG1j_i6mLFZ6vat0SF_TcP0AsWxh541mujfZ8v2QgXEYVB4OcUOGz
    8L1S-sGYi26NTFXGL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-A-kZKLBAxdDoaIjkb9VkHBZXUaDP5GSWs9DJW0RlYDnzLhw_g-_dQ>
    <xmx:-A-kZCFqzG5BZfZGEk72aIsC9mV8qyyuq2WHqf7kofy3mJGwpCEc3w>
    <xmx:-A-kZGWaEoWiFM3DVnE_pIRVNfvOdunOcWzm3pKBMekHEvvTH1GgSg>
    <xmx:-A-kZHtfA1FxCKncC-yJ6kkYFO3ldXBwf5BNX1MJdRwGbYbVs9hnSg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7578FB60086; Tue,  4 Jul 2023 08:26:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <788147c6-defd-496a-8174-1571b73d1a71@app.fastmail.com>
In-Reply-To: <f4bc3739-3ff1-6fa7-5d7d-890f451315bf@amd.com>
References: <20230703123557.3355657-1-arnd@kernel.org>
 <f4bc3739-3ff1-6fa7-5d7d-890f451315bf@amd.com>
Date:   Tue, 04 Jul 2023 14:24:09 +0200
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

On Tue, Jul 4, 2023, at 08:54, Christian K=C3=B6nig wrote:
> Am 03.07.23 um 14:35 schrieb Arnd Bergmann:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> On 32-bit architectures comparing a resource against a value larger t=
han
>> U32_MAX can cause a warning:
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1344:18: error: result of =
comparison of constant 4294967296 with expression of type 'resource_size=
_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constan=
t-out-of-range-compare]
>>                      res->start > 0x100000000ull)
>>                      ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
>>
>> The compiler is right that this cannot happen in this configuration, =
which
>> is ok, so just add a cast to shut up the warning.
>
> Well it doesn't make sense to compile that driver on systems with only=20
> 32bit phys_addr_t in the first place.

Not sure I understand the specific requirement. Do you mean the entire
amdgpu driver requires 64-bit BAR addressing, or just the bits that
resize the BARs?

> It might be cleaner to just not build the whole driver on such systems=20
> or at least leave out this function.

How about this version? This also addresses the build failure, but
I don't know if this makes any sense:

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1325,6 +1325,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devi=
ce *adev)
        u16 cmd;
        int r;
=20
+       if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+               return 0;
+
        /* Bypass for VF */
        if (amdgpu_sriov_vf(adev))
                return 0;

     Arnd
