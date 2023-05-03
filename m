Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF346F607F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjECVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:22:27 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980756A61;
        Wed,  3 May 2023 14:22:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EEFA5C01C1;
        Wed,  3 May 2023 17:22:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 May 2023 17:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1683148944; x=1683235344; bh=vkO0ztCMvjXTnReErYaR/lu+lP84Bh14IHf
        bhLWpzJM=; b=wX2hu0Y20uP/wj/9ULiM3v7p0X14AfSbO7e8mM1u9q0G2Z4RusS
        xyT5EC9KwqUemVe/Tfh4S+K73HrpLSCXtW+dZgJ16FuH2zLXRj5Tnl6Z4cFhZpZ4
        8UH0hjKLpP02oJVl9Qk8dLYEDZOUfCvMX+Mi5tG+MtUbB0qEnubuGC2JnXCIRrZw
        j0J7zy8Y5Py1SoUQvemAOWRB+Ol6/bZagxFftUhLwjz8b73a5vK43ff8bqNPzhhj
        873Z/2Hu0IV9FWhY/ZOnWqf5mjRcLrdJOmFJmcJ5Oyr5Afv2yT6bgwY1IuPZrAhz
        BRQcyGYg1IQbwctCmUUguyDgkyh2A33yYLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683148944; x=1683235344; bh=vkO0ztCMvjXTnReErYaR/lu+lP84Bh14IHf
        bhLWpzJM=; b=AC5Yr/wogC98ll8sPwixWfPXgPff/DxWgC1ecpR7RI9+e6gXs3f
        uIGE9Bs0Y0PlZK7fWR5OCN7BUv+szI/39lONnSKvKKSU1zsbFu3S5cIfZupJlB1y
        o+/JALbVMxPr3dYylHH3iXxvPkLZ6oT+sQMUnALdKAQhoJG9vJ/tOR6HyZmCWE/A
        oA/kUqT37THLkxg84oj1U+QH/u0OLVTPlEqFBxp+lPKkHY1ZbtA62yWjKnItRrd/
        uFW+8gLqYnk79uOX/j5fd9tlvEQfRBhta4hZ61Vjh2ew6CRWOHofChEB1yRLDJfp
        ufAosD0fwDLK+qwrHGVkF2VQ5Gjv/46RNCQ==
X-ME-Sender: <xms:j9BSZMSDaAn047tSY_wQF2IGRryGXgLoJwHFtNaEmtsNCWktGf6UEw>
    <xme:j9BSZJxOiKBlsWksJfLA_d9tGC_ytKgn1IRtAtzTqVKr6fz0Qo3v3_v5cxUqisSxf
    YGmtIkvsjzGea6LLrs>
X-ME-Received: <xmr:j9BSZJ342YfhhneNX3YE5jzVVEekCOWJekY3cRkE23GZ5xKdTzcZXAFdERKEhWPH588pqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvvefkjghfofggtgfgse
    htqhertdertdhsnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeffleejheffgfduveeihffhkeelheeuve
    dugfdtvddtvdeffedukeevteekuedugfenucffohhmrghinheprghsuhhsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:j9BSZABVy0jxiW47OcAJ2dop3_yG54EFYK3wjpv5IrgDGSO_eS4tDA>
    <xmx:j9BSZFj1NEUN7U1qT7o8xIwy5f5mEAcQfYjPAFraG_xEyT15azFADw>
    <xmx:j9BSZMoiAAq2YtPM8PSK7MX4sFTPHoMDG7PFV63GfAic2qCNC9GV3g>
    <xmx:kNBSZAVizhTiFQWae9qkCb5qOUrwZLg1YbU9h8HVpcD2iYOx6ntXxQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 17:22:16 -0400 (EDT)
Date:   Thu, 04 May 2023 09:22:03 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] platform/x86: asus-wmi: add support for ASUS screenpad
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Message-Id: <R0Q3UR.1AXX7YQ75CIN1@ljones.dev>
In-Reply-To: <_BfjSVwlhmByGevAd1Yo_jhipUa3r6y5HHSi34xdeaYqelyPe1PRnOEru21Yw76x0spJwAAs3jr0MJ0f_jUc8QY75Q1J1ovT5QPvm0p2WhY=@protonmail.com>
References: <20230503040207.257406-1-luke@ljones.dev>
        <_BfjSVwlhmByGevAd1Yo_jhipUa3r6y5HHSi34xdeaYqelyPe1PRnOEru21Yw76x0spJwAAs3jr0MJ0f_jUc8QY75Q1J1ovT5QPvm0p2WhY=@protonmail.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, May 3 2023 at 17:46:53 +0000, Barnab=E1s P=F5cze=20
<pobrn@protonmail.com> wrote:
> Hi
>=20
>=20
> 2023. m=E1jus 3., szerda 6:02 keltez=E9ssel, Luke D. Jones=20
> <luke@ljones.dev> =EDrta:
>=20
>>  Add support for the WMI methods used to turn off and adjust the
>>  brightness of the secondary "screenpad" device found on some=20
>> high-end
>>  ASUS laptops like the GX650P series and others.
>=20
> Is it this one: https://www.asus.com/content/rog-screenpad-plus/ ?
> Or is the "plus" version something different?
>=20
> If it's a "proper" screen, wouldn't it be better to add support for it
> in the respective subsystems? E.g. why not register a backlight=20
> device?

I think it is similar yes, likely the same thing.

Adding as a proper backlight is what I wanted to do but at first blush=20
I wasn't sure.

Looking at include/linux/backlight.h + some examples it looks clear=20
now. I'll try to
work up a revised patch and get it tested by the folks with the actual=20
laptop.

My only possible issue would be how to handle the on/off part?

Cheers,
Luke.



