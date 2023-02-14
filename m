Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6677A695A73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBNHRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjBNHQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:16:56 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758EF1E5F9;
        Mon, 13 Feb 2023 23:15:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DB6A93200947;
        Tue, 14 Feb 2023 02:15:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Feb 2023 02:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676358907; x=1676445307; bh=edXucQCtqv
        3gBphyaRbCejRt6W1/NTXsejr+xfq3GSA=; b=uE+Yd1wzC7KqPD14mJtr+6GQEl
        jGW9fQUM99GWFz01ZBhXx2Z8kGfu4cfgEjlkOg7cIRshFkicM3A5g1fdyLjoFzCr
        1VNIYRaeUmtGSpBLlA6Zs0yWxlqM+QS0pCqtUYAe39N0qnBKHDvKm5IZmtYfsPzN
        unBcQgZXA0ZCPaNEmYP5MgjyApn5Xnce2UpR0Nrp9u7U2ecF5W0T8pIUxUWw1PGm
        Mfi1Fdwx1HhiuyYOeYZOz54i9/QmbbImDDhm0A2bhibFXJ1Abpk51MsxG6ue7DpZ
        05WA1PaHTxTdTH64LuIvFXHlFJKNhpve5BedKazrYpWdGctli3pFIQngn/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676358907; x=1676445307; bh=edXucQCtqv3gBphyaRbCejRt6W1/
        NTXsejr+xfq3GSA=; b=f7/mMAEVQCTK6qTr/fMTl4YKtRa8Fonrd1DIX1hrJe8I
        tOWezKvNZDQ17M4xEqKVcv8HxKWp731sbMBZ+THTGjPMRNInXXu5VHJPNhHaNUN6
        oXNdsLRzk1SpRC7tQZMIOn9ubJ0UOOfbnKvZLGTTxPgS6vSuSm7Hqr0b0vnJfFO5
        yqDk5o3beMOcSXHNBTRFysmrjegda6XwgL95+/ij+dLNUVNkYpx7GkU81AmfX/f5
        ih5pEuG99ApsWh36LVNN0WJvST7iOXb9xMXRwHxTlvl6nTqJ/9YWV99u3aG3tR7N
        p/z7j6bQUP4db3fA8HnkUD6qyAPT9I0LLKiJhsk8UA==
X-ME-Sender: <xms:-jTrYx_lCHCIvoFSVCNPe0R_yF9O4l-T6lDHwNWzgVzarhitfsDzrg>
    <xme:-jTrY1uELRSyd8WPGIQKRiq3DPhQcnbqHYJR7W6zafwBh5teXovuvzJU375v4TgOx
    m0fQYz81RVRFkC-ciI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:-jTrY_B0j2EOTMr55DvIxA5JkZu9dN8NnCcktPe4v2RocI3JTiTkDw>
    <xmx:-jTrY1fWR59g5_6T-Axh1Yv6_oms58VJmLURTA9MsJlLbBiCK01GYQ>
    <xmx:-jTrY2MxoKI4qZMYnRqfEM6VhqFHpaTaR0C0drtyTiu97O02BJx1bg>
    <xmx:-zTrY9o6a91LvxmD-GS_RP3jRLs_nRosY623k7mhbLTpVwV1DYE2oA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A4B85B60086; Tue, 14 Feb 2023 02:15:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <94b362b4-a30d-4b69-8126-a64f5d025740@app.fastmail.com>
In-Reply-To: <3d94fc3f-fbe5-a56e-3713-4f0788ebc7f9@opensource.wdc.com>
References: <20230213101143.3821483-1-arnd@kernel.org>
 <3d94fc3f-fbe5-a56e-3713-4f0788ebc7f9@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 08:14:48 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Brian King" <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Kees Cook" <keescook@chromium.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: ipr: work around fortify-string warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023, at 04:59, Damien Le Moal wrote:
> On 2/13/23 19:10, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>

>>   **/
>> -static int strip_and_pad_whitespace(int i, char *buf)
>> +static void strip_whitespace(int i, char *buf)
>>  {
>>  	while (i && buf[i] == ' ')
>>  		i--;
>> -	buf[i+1] = ' ';
>> -	buf[i+2] = '\0';
>> -	return i + 2;
>> +	buf[i+1] = '\0';
>
> If i is now the size of the buffer, this is a buffer overflow, no ? And
> the initial loop should start at "i - 1" I think...

Right, I definitely have the wrong length here.

>>  }
>>  
>>  /**
>> @@ -1547,19 +1543,21 @@ static int strip_and_pad_whitespace(int i, char *buf)
>>  static void ipr_log_vpd_compact(char *prefix, struct ipr_hostrcb *hostrcb,
>>  				struct ipr_vpd *vpd)
>>  {
>> -	char buffer[IPR_VENDOR_ID_LEN + IPR_PROD_ID_LEN + IPR_SERIAL_NUM_LEN + 3];
>> -	int i = 0;
>> +	char vendor_id[IPR_VENDOR_ID_LEN + 1];
>
> ...but the size is in fact "i + 1"... So in strip_whitespace(), i is the
> index of the last possible character in the string, and given that the
> string may be much shorter, that function may not actually strip
> whitespaces after the string...

I think aside from the off-by-one bug I introduced, this is not
a (new) problem as the old code already assumed that the input
is padded with spaces rather than nul-terminated.

>> +	char product_id[IPR_PROD_ID_LEN + 1];
>> +	char sn[IPR_SERIAL_NUM_LEN + 1];
>>  
>> -	memcpy(buffer, vpd->vpids.vendor_id, IPR_VENDOR_ID_LEN);
>> -	i = strip_and_pad_whitespace(IPR_VENDOR_ID_LEN - 1, buffer);
>> +	memcpy(vendor_id, vpd->vpids.vendor_id, IPR_VENDOR_ID_LEN);
>> +	strip_whitespace(IPR_VENDOR_ID_LEN, vendor_id);
>
> So this call should really be:
>
> 	strip_whitespace(strlen(vendor_id) - 1, vendor_id);
>
> Which means that this helper can be turned into:
>
> static void strip_whitespace(char *buf)
> {
> 	int i = strlen(buf) - 1;
>
> 	while (i > 0 && buf[i] == ' ')
> 		i--;
> 	buf[i+1] = '\0';
> }
>
> Unless I am missing something :)

The strlen() here requires the input to be a properly terminated string,
so this would at least require adding a \0.

Also, if the input is a short nul-terminated string instead of
a space padded array, we probably don't need to strip the trailing
whitespace, or at least the original version didn't either.

Let me try to respin my patch with just the off-by-one error
fixed but otherwise keeping the output of ipr_log_vpd_compact()
unchanged.

      Arnd
