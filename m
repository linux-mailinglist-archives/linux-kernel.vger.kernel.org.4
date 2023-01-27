Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567DB67E196
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjA0K2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjA0K2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:28:05 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1FC30E8;
        Fri, 27 Jan 2023 02:28:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 68F6E3200976;
        Fri, 27 Jan 2023 05:27:59 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Fri, 27 Jan 2023 05:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674815278; x=1674901678; bh=TGJCXNFd51
        vNxeV7bRMb8/J/tzSpB7ShFOCJd2Bb6zc=; b=YXz6gwM9iYCYCNuLb/HKSxYX5D
        MU3HtIGxyLBqHMt7whFO5nSkvJ1fc9TztLINa8TLQD6egpny0P2kKOEme5UpTeeg
        Ty29ku/qK2k/fKMmTUPTfeTDg0AeZDaN4FCmO77gCZrD/lC5J87rCh5EjhpSsas9
        ds4LjXnd/rrYTyg2AlhAWQv+vBaHBryTRNtEw4rSvbKt95teit7DojTHrY6pbbfC
        RFf3sSzpvwZMKkHwcuI7sSYykE1YIKwjH+BZiBDdGPomPsoiUUi4K5d7SHZYJcDj
        L3NWwcaRWq40ssfFAWjY+bBeCEnqj3jaycMFYlMCa6Qg2+ErTIsK6fDirA6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674815278; x=1674901678; bh=TGJCXNFd51vNxeV7bRMb8/J/tzSp
        B7ShFOCJd2Bb6zc=; b=MLjfP4mSMRxRzikrZ/DMMXBbbQDoFSTBs3rxqH5eVdvv
        4/VXe40/wIKnnhAfopLCdT7kd2hL1oesrc9eNPysVlhRorP0vqaYX/54f365iljh
        1pyzydNSlkhP39VGmtOQFC0d9wUZccjITxYeDOGwBHDzc3mUPQv86smbbi4ALx6z
        74O4QaW2kkgZZShcWNgdHrmLKt935JVlhYVO9l4YzcBX2csUB6Qvl0cQa6YyKz0f
        /IQEiphSWSMOhKN6Oa8uMCorpdTnlF3o/h0fq4FEiI0PX7/qQX5iM4KMBEIK2lyc
        Bk39LV2WPLDeihTpNlfOCcWXswkFOWON5/D+b7bxOA==
X-ME-Sender: <xms:LafTY8ugB1JhdoFjR66OshMgF_0bcdXHBY6kW8Cr0-3dckp4axa3ww>
    <xme:LafTY5f0z1T-L19obnxxX0CHMLMZn_uxn-MVq8DiKdlxcr7rnAR9KncWInwE1UTgq
    Ei8gPtI0xh0MVfmt3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfffgr
    vhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihgusehrvggruggrhhgvrggurdgvuh
    eqnecuggftrfgrthhtvghrnhepfeelgeeuheeihfeuleefleehtdektdeihffguddvheef
    iefhveelhedvvdfhueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepuggrvhhiugesrhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:LafTY3wm31Zml2dkQncjbncEZUE40JsF2wW1LPIODian3Pzlasjxyw>
    <xmx:LafTY_M2ysAvGxIr9WuFxBSu2hqWIHEPjucF3xsMgBL2J6FYV9zmGg>
    <xmx:LafTY897v2H3NE77Y7cocpfCgNqGloo-CqDL1Y8HxBPHcUA61a4bGA>
    <xmx:LqfTY8zOmoqh9iBid_1ACigOphPuHZQS0Bb9goZBIdpZb_U_0VbCaA>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DE5BC1700089; Fri, 27 Jan 2023 05:27:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <16641a56-9139-4396-a5a8-89606bedd1f1@app.fastmail.com>
In-Reply-To: <Y9ES4UKl/+DtvAVS@gmail.com>
References: <320c4dba-9919-404b-8a26-a8af16be1845@app.fastmail.com>
 <Y9ES4UKl/+DtvAVS@gmail.com>
Date:   Fri, 27 Jan 2023 11:27:25 +0100
From:   "David Rheinsberg" <david@readahead.eu>
To:     "Ingo Molnar" <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH] x86/insn_decoder_test: allow longer symbol-names
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo!

On Wed, Jan 25, 2023, at 12:30 PM, Ingo Molnar wrote:
> * David Rheinsberg <david@readahead.eu> wrote:
>> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
>> index 472540aeabc2..366e07546344 100644
>> --- a/arch/x86/tools/insn_decoder_test.c
>> +++ b/arch/x86/tools/insn_decoder_test.c
>> @@ -106,7 +106,7 @@ static void parse_args(int argc, char **argv)
>>  	}
>>  }
>>  
>> -#define BUFSIZE 256
>> +#define BUFSIZE 4096
>
> That hard-coded constant is a bit lame and will cause trouble the minute 
> *that* size is exceeded - don't we have some more natural figure, such as 
> KSYM_SYMBOL_LEN?

Thanks for the hint! I tried mentioning this in the commit-message. I am unsure whether a fixed-size limit is the correct thing to do. However, given that this is a compile-time test-tool, I thought bumping the limit for this stack buffer to be sufficient. I am open to other suggestions.

The input to this tool is the output of objdump, so effectively annotated x86-assembly. To get a proper estimate of how long such a line could be, I would have to audit all instructions and know what kind of arguments are possible. Can some of them take multiple symbols as argument? Are there other possibly long encodings of arguments to consider?

Lastly, shouldn't this use KSYM_NAME_LEN rather than KSYM_SYMBOL_LEN? And then how much room for normal instruction-encoding should I calculate? I feel like whatever I do (even with those constants), I would end up with only an estimate and wouldn't actually end up closing this issue.

The current workaround is to just disable CONFIG_X86_DECODER_SELFTEST, which I thought is a sad state. I can gladly use `256 + KSYM_NAME_LEN` and add a comment ala "room for insn-encoding and a symbol name". Would that be acceptable? The alternative would be to try to dyn-alloc a buffer and increase it to the actual line-length?

Open to suggestions!

Thanks
David
