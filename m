Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAECD7333D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345654AbjFPOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjFPOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:42:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5603730F3;
        Fri, 16 Jun 2023 07:42:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 178FF5C01AA;
        Fri, 16 Jun 2023 10:42:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Jun 2023 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686926552; x=1687012952; bh=4V
        GcUvtGEtw5RjxdkUnMC4EdyRen1ofbtMRBLCbhZxI=; b=ocdcBE3F46DzA6dg9C
        SfDfRt0GTts1Qt1RyXWYtzbnfZt1E5amhSiKHlX+aLFdbamOntr5ZuqDZghOhfY1
        mpbGXeodcqbPc2TQxxH1L7Px+nepEcH7a2Whx/qFga3WBsfxcNudt3X6aFRwUEk7
        KtuskHiMd55lww3dta/SyCP76MEAR1eK55gxBpNElt7e1C76jwhXEGG7haW2yWiv
        cxhfX3nXb2zwkEsWUujquiy4WR++oZYb9nA2k74QejLxfO5j3Y+0yJRRq41KAOdh
        7EKEdIzem7+EcNBFmAHnGe0tMI6cvg5Eg3iZA0/ip+u5Uyh2KN1nxHYOPVk3i9bI
        FbUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686926552; x=1687012952; bh=4VGcUvtGEtw5R
        jxdkUnMC4EdyRen1ofbtMRBLCbhZxI=; b=ENMlyKe0rLiO7AjUzkgxdJAWtZ3Ix
        NurGOr3ec7kD8JWlrJyE3KppO0u5rN4hIJRqyUPRsieAQbXzmmZ2WIxfx8rX2Emf
        jsgNSxJiUAf9ZMWm9FfPL6DJ+RSp+warATmJsgqyl50Xs5GxAYUgpzZyjP0ooOo/
        Pgch7FIvvbrQlXeGGSxW5uDCPnineM40v0BNlsxXuX4w40OsByelhALpnMj8/9gH
        BF6hqcjT2PqP67kCt+g6JJ3tGFQMF6obsk7lCglNHM1eegFinTz545INKNSHB17L
        Sl0pu11w9IX+mBIPAgsKtXVMbqSU8jTbMi+wW4J8erKKB1x3DKymfjWkw==
X-ME-Sender: <xms:13SMZHOjKdgeY8RqeGIuRpQTnAHItlvYFWKb85KFnAaMjI04n5SKkA>
    <xme:13SMZB8GjiIEV1m1NP_lPUfit9vVqivOy7L-UJ1JOsYpGKMsn6mRpbxnxIVuHHohn
    OTGa86XyCIJ5blVE8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:13SMZGTN7M1QUZviaLNC3wZAgX5Du_qMaTzLp5BhvsEuOVfX_jN5tA>
    <xmx:13SMZLu3bsPg8QVPRAsD5MaNNl3O_NuQypbsiCZJGtHE1UI7WkScZg>
    <xmx:13SMZPcA3nUlAsZll98ljVPOeCEI_x9jdKKOkgMxSRRNxXjwtcyggQ>
    <xmx:2HSMZK0t0DvXikhafboeUF2PfwlrewSk155sWP66D9OIJoeJzFqBNw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 386D4B60086; Fri, 16 Jun 2023 10:42:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <6742b2ce-02f1-43c1-811f-de7fd0a74f6a@app.fastmail.com>
In-Reply-To: <CAKYAXd-j6mJ91hZUZi86HnGJahekHHgYz4ngWfF81QmYigGqVw@mail.gmail.com>
References: <20230616090749.2646749-1-arnd@kernel.org>
 <CAKYAXd-j6mJ91hZUZi86HnGJahekHHgYz4ngWfF81QmYigGqVw@mail.gmail.com>
Date:   Fri, 16 Jun 2023 16:42:09 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Namjae Jeon" <linkinjeon@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Steve French" <sfrench@samba.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        "Tom Talpey" <tom@talpey.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Dave Chinner" <dchinner@redhat.com>,
        "Kees Cook" <keescook@chromium.org>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Hyunchul Lee" <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] smb: avoid field overflow warning
Content-Type: text/plain
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

On Fri, Jun 16, 2023, at 16:40, Namjae Jeon wrote:
> 2023-06-16 18:07 GMT+09:00, Arnd Bergmann <arnd@kernel.org>:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> clang warns about a possible field overflow in a memcpy:
>>
>> In file included from fs/smb/server/smb_common.c:7:
>> include/linux/fortify-string.h:583:4: error: call to
>> '__write_overflow_field' declared with 'warning' attribute: detected write
>> beyond size of field (1st parameter); maybe use struct_group()?
>> [-Werror,-Wattribute-warning]
>>                         __write_overflow_field(p_size_field, size);
>>
>> It appears to interpret the "&out[baselen + 4]" as referring to a single
>> byte of the character array, while the equivalen "out + baselen + 4" is
>> seen as an offset into the array.
>>
>> I don't see that kind of warning elsewhere, so just go with the simple
>> rework.
>>
>> Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  fs/smb/server/smb_common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
>> index a7e81067bc991..e3273fa640b07 100644
>> --- a/fs/smb/server/smb_common.c
>> +++ b/fs/smb/server/smb_common.c
>> @@ -536,7 +536,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
>> const char *longname,
>>  	out[baselen + 3] = PERIOD;
>>
>>  	if (dot_present)
>> -		memcpy(&out[baselen + 4], extension, 4);
>> +		memcpy(out + baselen + 4, extension, 1);
> Is there any reason to change copy bytes from 4 bytes to 1 byte?
>

No, that was an accident, this patch is wrong.

I have to revisit this one and check if my change actually still works
after I change it back to the correct length.

      Arnd
