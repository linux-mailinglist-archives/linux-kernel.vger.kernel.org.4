Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62CD64817F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLILSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLILSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:18:00 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981652E9C0;
        Fri,  9 Dec 2022 03:17:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1013C5C013F;
        Fri,  9 Dec 2022 06:17:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 06:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670584678; x=1670671078; bh=02+SGIrsh9
        aXXJRxaDR3edUo75PItu/i4cDwFPHk0qM=; b=RzRj1oeeJ8wJ/GsvZ4Ys8QnTtC
        qNGqAfZMRFfGDBbXAmlEPLUIy6I+czuaFEqawEyqMDikInTMYXFTcBspazfYpQB4
        xBGLAanH34tPTS290djatfQqB1GLqQcj4uxDgMRSsAj2qwn11yf3DjEJaUlkCjE9
        rRjgUlb6D2/O+vXw6pAwcAX3DFWx5ui7enILKXRONSmaCwtV0kki8I+4NbAYIisR
        Mfy5V2t0hMHVCSZMaLUVRxSyURIwXMWfBb8cRCYMOdr8aAydxLoSouICaYx9rFrD
        M0yyqvF9Ae9c/pFMccxil3qKYQOZzve5nKeo8kaRKZcsjkO6gPwSCdF4iQBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670584678; x=1670671078; bh=02+SGIrsh9aXXJRxaDR3edUo75PI
        tu/i4cDwFPHk0qM=; b=Kz1FgZR6UivKklO3QbYWzFcPfFvA2TkrYLFNgyhgBHKc
        pVwSGFVwezfYZ9wHJZWij04g2dapjYKTooOYPYPqymG84udMaWK/3R3PZ2gDA+/s
        AzkQdC4hb1FWyT5cgM49TL3Kk2791IyXGPYnAFU2UEsaA8BEgKgUesdbSjeSVaO3
        dChHijgYGfp0A7siilFe4qgPtM9rDcU3O6zDlHcYDkJ3/geASc3OTxT6ajgvpnD+
        Ck67JnFBFBRPzJQ39iCN6R70onGB1jLBImNOMqjXyOXsGzsL6q4lWMaOidPBIOuW
        C/LSu2jA/vwvWwcofZdIVF4CeDJbiLf9ji4zz5vukw==
X-ME-Sender: <xms:ZRmTYzqp7iE0j95eLPtCjsMlGYvazapGEj31k6isaaD6JGhV4-uM2g>
    <xme:ZRmTY9pFFnROs0kLR8N6DXi9NfjtIycizeKKLwWBnvc9rMDWogWwLCdlKuBoSgIvs
    Tyos_faMcTH34nSxz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefgudfg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZRmTYwPyldiR6xIx4k__Ilko4PSsbgOxKuJ36LUVsaJzxjZV7CmOWQ>
    <xmx:ZRmTY24p7uhtCsMZnHa-fbQETIfxLU6H3TyG_96lzSMAAikgMH8MUA>
    <xmx:ZRmTYy48TPgpw8NUhC2PQmotaiUOjTwUXc3e2hgXK0DxeEGLHnvr5Q>
    <xmx:ZhmTY0S_5jBf_Mpbof-sr9sqyf7TL9VDmSt4ClFsNtkhGBVqPCw0yw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 71BCCB60086; Fri,  9 Dec 2022 06:17:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <0c621478-6429-4a7c-9c14-5fab7017d1e8@app.fastmail.com>
In-Reply-To: <20221209013309.407879-1-jk@codeconstruct.com.au>
References: <20221209013309.407879-1-jk@codeconstruct.com.au>
Date:   Fri, 09 Dec 2022 12:17:36 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jeremy Kerr" <jk@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 0/3] Add reset control for mfd syscon devices
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022, at 02:33, Jeremy Kerr wrote:
> This RFC series adds a facility for syscon devices to control a reset
> line when probed; we have instances of simple register-only syscon
> resources that need deassertion of a reset line for the register set to
> be accessible.
>
> Rather than requiring a specific driver to implement this, it'd be nice
> to use the generic syscon device and the generic resets linkage to do
> so.
>
> Any comments/queries/etc are most welcome.

The syscon side looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
