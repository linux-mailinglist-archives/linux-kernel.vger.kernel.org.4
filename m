Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDF695AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjBNH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBNH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:28:02 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795532738
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676359675; x=1707895675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fKqsbgGPsuWCWt5qDLOSS1XjcnbLNzAiPOl9OxHQsLM=;
  b=VAowxglM/EE8Rd7vUmx7UUE5atxUF5NkK3whJDIQ1sbe5USY+XKhq11a
   SvWpTibdtZNrxpG+KYM5kvKcNKJRIznAIl+XS6Iv/RluElp8GHOnavN+g
   MxomEqvbAehv3LGK/53Ow1Rb9hsItAxtzdRtWmzrTji0kCgjI7bRhWops
   7M3KtB5yz5poDRkqMMMvS1aqNMLB3lUFUDoBXktraMnJUoZtbhxWuiblx
   fjkq9Oj3ob4iaf7XwLwFXsFKZc7+BQaRGDsebNf4hZXwSFkuUzd/CSJLc
   7bHDIQTYwInaI3iLdm3c+zrhXIDIXpmWjAweu8x7kHBm3S2QSO6QCUkUb
   g==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669046400"; 
   d="scan'208";a="228219320"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 15:27:54 +0800
IronPort-SDR: pLIhsEu0JnAFXLFpYWRcOwanhtYwhwu+Bl3lMmZs9zlbNjLfJzXrcpbrJ/KVbZq9nuk+BxZxJr
 a1UoKyi3LlLIee2/jLSFavaq0xSKoPYMLSseg7Oaw7mlJQI60im+3BUSanxcRHUTYWHFs831sj
 Y5SOHDkAGvME+kHxSAQFH68hdDDGNVKN3Ng8aLMT2rkkLT40DvbQe4JjU86usBOUmOufDeMsf/
 bQBQ60A561bSywVp1rxrTFZnDlvZKTrqjmrHZEXcqHt5CzRubdOsbU3VaHB2nuW95PhpGtpNbf
 GQc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 22:45:02 -0800
IronPort-SDR: SyAzyvghB5ka6v0bsH7tABPrTVYEL5O34yFeCoswPf/7Ups1ObzLEt9HvBVgVxdy7o2hWprrSD
 FChbBAZVZEaaqEzVFv0VmErB1R4KDvkqhFMv7cueTFsO5Snk45uKmdAvLk1QTNjIRRd47A6/6/
 lBrH4YqcrjAh2qBGhfIsF4dtSQSwQNbmmXcMC1Kcnq0Oilz2JWHuI7HNAB/UIL+D4mvDr9/ujM
 vDegAdGvPHek5w1gqe3yagW2UBZPZIYhS91diCSUza0Tz3+470b26MD0d3Ux9TunoAR8HYeaC1
 f1c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 23:27:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGCV21wZ9z1Rwt8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:27:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676359673; x=1678951674; bh=fKqsbgGPsuWCWt5qDLOSS1XjcnbLNzAiPOl
        9OxHQsLM=; b=qLBsRkuvgw2X455pPBLbc9DStaa/OCukEQXQRY2Wz6jlqoGYX7l
        Dk6XTYLcm5BasJgQgx5GFJBNLLDA6LdTYDBePk8N5yOvIKXXOyy8RhZMLezRyBOz
        MTO2+tSH4IkEPkDd9vt9Sx+lvUwQd/QQTwkc9dBfv1gQCf9tEjnXjndxNltzc7W0
        PcXbBjAJM50oznYEigYII42+YxgwGOuV4QOiolfQRTPmvnXZGbcjfQ1GFTeJ0EPe
        Vla7PL3geXYrSgMwFEoRGwuWQl0b0t+slE71bNkB5EiQd+EJCWsEVRNmSnGs3SCA
        rj/vgeD8DZFlzjPtu9/5bFqgSJ/cf2r015A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aSZO4pUBy6c9 for <linux-kernel@vger.kernel.org>;
        Mon, 13 Feb 2023 23:27:53 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGCTz3h31z1RvLy;
        Mon, 13 Feb 2023 23:27:51 -0800 (PST)
Message-ID: <9b335f88-a20a-83da-3ce1-df409e05004a@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 16:27:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] scsi: ipr: work around fortify-string warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230213101143.3821483-1-arnd@kernel.org>
 <3d94fc3f-fbe5-a56e-3713-4f0788ebc7f9@opensource.wdc.com>
 <94b362b4-a30d-4b69-8126-a64f5d025740@app.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <94b362b4-a30d-4b69-8126-a64f5d025740@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 16:14, Arnd Bergmann wrote:
> On Tue, Feb 14, 2023, at 04:59, Damien Le Moal wrote:
>> On 2/13/23 19:10, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
> 
>>>   **/
>>> -static int strip_and_pad_whitespace(int i, char *buf)
>>> +static void strip_whitespace(int i, char *buf)
>>>  {
>>>  	while (i && buf[i] == ' ')
>>>  		i--;
>>> -	buf[i+1] = ' ';
>>> -	buf[i+2] = '\0';
>>> -	return i + 2;
>>> +	buf[i+1] = '\0';
>>
>> If i is now the size of the buffer, this is a buffer overflow, no ? And
>> the initial loop should start at "i - 1" I think...
> 
> Right, I definitely have the wrong length here.
> 
>>>  }
>>>  
>>>  /**
>>> @@ -1547,19 +1543,21 @@ static int strip_and_pad_whitespace(int i, char *buf)
>>>  static void ipr_log_vpd_compact(char *prefix, struct ipr_hostrcb *hostrcb,
>>>  				struct ipr_vpd *vpd)
>>>  {
>>> -	char buffer[IPR_VENDOR_ID_LEN + IPR_PROD_ID_LEN + IPR_SERIAL_NUM_LEN + 3];
>>> -	int i = 0;
>>> +	char vendor_id[IPR_VENDOR_ID_LEN + 1];
>>
>> ...but the size is in fact "i + 1"... So in strip_whitespace(), i is the
>> index of the last possible character in the string, and given that the
>> string may be much shorter, that function may not actually strip
>> whitespaces after the string...
> 
> I think aside from the off-by-one bug I introduced, this is not
> a (new) problem as the old code already assumed that the input
> is padded with spaces rather than nul-terminated.

Yeah. The HW probably always give the same amount of chars with short
strings completed by spaces...

> 
>>> +	char product_id[IPR_PROD_ID_LEN + 1];
>>> +	char sn[IPR_SERIAL_NUM_LEN + 1];
>>>  
>>> -	memcpy(buffer, vpd->vpids.vendor_id, IPR_VENDOR_ID_LEN);
>>> -	i = strip_and_pad_whitespace(IPR_VENDOR_ID_LEN - 1, buffer);
>>> +	memcpy(vendor_id, vpd->vpids.vendor_id, IPR_VENDOR_ID_LEN);
>>> +	strip_whitespace(IPR_VENDOR_ID_LEN, vendor_id);
>>
>> So this call should really be:
>>
>> 	strip_whitespace(strlen(vendor_id) - 1, vendor_id);
>>
>> Which means that this helper can be turned into:
>>
>> static void strip_whitespace(char *buf)
>> {
>> 	int i = strlen(buf) - 1;
>>
>> 	while (i > 0 && buf[i] == ' ')
>> 		i--;
>> 	buf[i+1] = '\0';
>> }
>>
>> Unless I am missing something :)
> 
> The strlen() here requires the input to be a properly terminated string,
> so this would at least require adding a \0.
> 
> Also, if the input is a short nul-terminated string instead of
> a space padded array, we probably don't need to strip the trailing
> whitespace, or at least the original version didn't either.
> 
> Let me try to respin my patch with just the off-by-one error
> fixed but otherwise keeping the output of ipr_log_vpd_compact()
> unchanged.
> 
>       Arnd

-- 
Damien Le Moal
Western Digital Research

