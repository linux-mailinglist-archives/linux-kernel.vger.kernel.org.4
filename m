Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C67172B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjEaAlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjEaAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:41:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A086E59
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:41:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso5993109b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685493661; x=1688085661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdGugcn5c2JbfD3Z/D2lhqlqML+TkkwlsJOLG2bXoh8=;
        b=Y5plRcLGLfqdQbw1UCKZWDoHUbZNcvVwqz2tAS84QoUFIX61CaS013NTvJ/l+TcnRL
         uQBOKbUzrfPkieJ8GvjW/G0Hg3GswjuPNFXEwDtNQYUzUHX1+t8nV6YftMloja+Nuw1k
         Bzhj1i5IB7rhPSpiBllVKoSGl4T2LkbkVqiSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493661; x=1688085661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdGugcn5c2JbfD3Z/D2lhqlqML+TkkwlsJOLG2bXoh8=;
        b=Ka/VtsN+2KIb2CXr1LB9S6gwJwmqVJIIZ55VV9Pm7/8jcTdKktQwiv4nHJ/RYV2ZNn
         Ik5gAtiQCGmBoLx86LcXPxLOGLDSclJxZTNlnZJjJ1/T1+pJVBImMQHP8NErXd6mI2Si
         3JHWjH1mtVwDnNXPpOam8RfCZL5NjjajmXRmxYei80qYCy0oWdvwu2/Vvyw98RkD5I5r
         z59kzHddXFMa+ofzH+6cdmA0PqzkplYVWmQ+jDqHXblPVMIXjWwL4RtNMdKJsZQkZh9M
         1+j0UREwKsNtMYalElXhrzRYFs0xbapkxvLedrf67SEVV9ZlUptHBmVRX73q5FN6EW69
         WbNA==
X-Gm-Message-State: AC+VfDwhb9fDFtN5TCzeZd7OoQX0a5uedo6pgMV1I/Sq8u04KJYHX93A
        2RDKiUjsoWLF2tWuIV6uX7NAtA==
X-Google-Smtp-Source: ACHHUZ6o1TQD/LukUZ04g3mHlB+kzTrtMEcpfvB36LePlbV5OsZ8XYnic1rrkt7epqhp0cNM6nA69Q==
X-Received: by 2002:a05:6a00:1a51:b0:64f:4812:8c7e with SMTP id h17-20020a056a001a5100b0064f48128c7emr4233724pfv.19.1685493660885;
        Tue, 30 May 2023 17:41:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j15-20020a62b60f000000b0064559b58eb8sm2141155pff.154.2023.05.30.17.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:41:00 -0700 (PDT)
Date:   Tue, 30 May 2023 17:40:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] checkpatch: Check for 0-length and 1-element arrays
Message-ID: <202305301738.92C6DE1D@keescook>
References: <20230527020929.give.261-kees@kernel.org>
 <75851e1185821084c0a1b7e5aaf60e9f38e0f792.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75851e1185821084c0a1b7e5aaf60e9f38e0f792.camel@perches.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 09:31:39PM -0700, Joe Perches wrote:
> On Fri, 2023-05-26 at 19:09 -0700, Kees Cook wrote:
> > Fake flexible arrays have been deprecated since last millennium. Proper
> > C99 flexible arrays must be used throughout the kernel so
> > CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> > bounds checking.
> 
> Hi again.
> 
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7430,6 +7430,21 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for array definition/declarations that should use flexible arrays instead
> > +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> > +		    $prevline =~ /^\+\s*(?:\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> 
> Ahh, now I see why you want to use (?:\}|$Type) to find
> struct arrays defined as the last object in another struct.

Yeah -- this has been a place where past "[1]"s have snuck in before. :)

> grepping for some existing variants, perhaps the $sline test should
> be extended to something like:
> 
> 		if ($sline =~ /^[\+ ]\s*}\s*(?:__packed|__attribute__\s*$balanced_parens)?\s*;\s*$/ &&

Ugh, I forgot attributes. Hmmm. I don't need this check to be _perfect_
either. :P Really only "__packed" has come up in other conversions.

> > +			if ($1 == '0') {
> > +				if (ERROR("ZERO_LENGTH_ARRAY",
> > +					  "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
> 
> Instead of github links, how about using:
> https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Yeah, though the issues have a bit more detail. Probably better to be
self-referential. :)

> 
> 
> Why not combine both of these into a single ERROR?
> What's the value in separate types?

Yup, with the same URL (instead of separate URLs), it gets cleaner too.

Thanks!

-Kees

-- 
Kees Cook
