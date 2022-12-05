Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6819F64284B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiLEMVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiLEMVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:21:35 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A8F5B8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:21:33 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8B01B320091F;
        Mon,  5 Dec 2022 07:21:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 05 Dec 2022 07:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670242890; x=1670329290; bh=8c
        0wk4OjXRa/QesbL2vsgHn8e80nbdEdde63Cqs79LU=; b=V00lIOL6pRsSMCtU95
        vKHxeJ4m9ufk9wwAspWvf1e3s6HrMeTbhsuyPc6OenXh52/DZ908dt0LANk8Vx0S
        rLL/MG16b64cOopmHEBwbZwf2fY4Crqhnv4G3mO4Dwaghlc6Nk32EpzscJS5nLzb
        LmDjElro2B1yCMpQYu6A8M8cnpWuHfixu1sI/L9Vw2MuimSj7k/HPQLDcuJJo1TQ
        6SJ45XSBha1WanrCd+qshB+b5VH/9HZvLfuPsOEkX2MblPXwlf4P+e1o0uIF52ev
        LA0KAkHX6o4Yi2DyTYUTztR2XyNkBMoyNIy7kZsqtk2/qOHQ/dMZxHFoEUVsuDOS
        SV/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670242890; x=1670329290; bh=8c0wk4OjXRa/QesbL2vsgHn8e80n
        bdEdde63Cqs79LU=; b=Ymhyjo4CLdPwJWL2RhBjtEKy6dSusKREfgc87T61vKIf
        CGj+zLKQL3C+rUPN6gxZH/40+YixrKB/OwcIPwFsjI0rVzzjBwMziYyum+ZYeYjz
        BB/HlkZlyU8usAhwwA3m9FsfripbzN/+jCHvVMxYNx4mOFRstdd8wPippq6Iugtp
        hU74td094dahVYhv5jS+rBZ3CHooGrUMVfdxIF+k8qH689U3NgXb2sDnjz1mS3+L
        d7RIYZaJ9VMDu2mt6RTiImlkGH3JH+KyarVKwklBY3FTAuYU8Hxyt1X4gw2SGCfG
        +Y0tOVnRg/qR+FdmXbGAJK/jAqn3vLXX6d8V6ltdvw==
X-ME-Sender: <xms:SeKNYwzby81n_Ik1yWuw7FbU6XHj6gT1MpOcxBQo0npxGZ9wJGX8vw>
    <xme:SeKNY0Qon2VKhKeEy2fsCSX9c2CR5rU7_39FFUaohkiLotopG-xSLIpLq-nYML1yR
    WUZkWrUez6jMhVYMN0>
X-ME-Received: <xmr:SeKNYyWVAVFt-7NaJhKpZlsbdJsINfdQjOzw8DIeyhTPx2sPRORC1FWote4m_G-iZaM3Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepfeeileeffeeiteeljeekheetieehhffhfeeuheel
    tdetgfeuvddvffegvdelhfdunecuffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehs
    hhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:SeKNY-gqq8KBVaqdhbT8aLT9CSgceXac2jwCevb7eSxY3VnBOGrWGA>
    <xmx:SeKNYyB5kaXxPKzax80FocyvquEdW7mtabPwsJWUPYt16T6FS9WJlw>
    <xmx:SeKNY_LuKRwfZ_PFkXwRtVJngfJ_VhMTDYDsEaR5e1yZKTDkX5lKjw>
    <xmx:SuKNY-0QBEEogwSFShv4Ahif-Nbx2x2FkaNqRB2FahP8xAb3yYLztA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 07:21:28 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6994610948F; Mon,  5 Dec 2022 15:21:24 +0300 (+03)
Date:   Mon, 5 Dec 2022 15:21:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
Message-ID: <20221205122124.3sixqn52i4xsdxbt@box.shutemov.name>
References: <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
 <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
 <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
 <20221202143316.mtjz6dghecshldk2@box.shutemov.name>
 <d7000f26-2640-074e-10f2-c5232feaa9fd@suse.com>
 <cf7db285-deaf-8e3e-2b35-7cecbaff7d61@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7db285-deaf-8e3e-2b35-7cecbaff7d61@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 08:40:06AM +0100, Juergen Gross wrote:
> > That's a question for the Intel architects, I guess.
> > 
> > I'd just ask them how to setup PAT in TDX guests. Either they need to
> > change the recommended setup sequence, or the PAT support bit needs to
> > be cleared IMO.
> 
> I've forwarded the question to Intel, BTW.

I've initiated the talk internally too.

> Another question to you: where does the initial PAT MSR value come from?
> I guess from UEFI?

It is set by TDX module on initialization. See section 21.2.4.1.2. "TD
VMCS Guest MSRs" of TDX module spec[1]

[1] https://cdrdv2.intel.com/v1/dl/getContent/733568

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
