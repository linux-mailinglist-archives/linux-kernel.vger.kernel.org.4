Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B57131D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjE0CBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjE0CBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:01:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7510189
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:01:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b0218c979cso4256555ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685152864; x=1687744864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3YbAt9JjfLvKqD7ym0b4r1+hkDKL9O0I3I3mZ5235s=;
        b=PG4NLHltyMPfbb4jzVRi5VCXYGRdpjmbMDYTsTkw5J6vyg/XRr1KresINXxLI57xOO
         vEtUdQjRy08+0IVetoNywf0g0V/k4oRGaCgwquyCUMv3f1YX1nTYanjDTjG/TX51BfLM
         RQxV+o8OUIxaPnp6aNMHIavpJB3O/xTixFbHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685152864; x=1687744864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3YbAt9JjfLvKqD7ym0b4r1+hkDKL9O0I3I3mZ5235s=;
        b=ZhKGKuFRXCdfLYQ29tidEX1YoRE7fjXDE0BpOnbiWjjFvgJmnbEQwW6tB28BDD2kdC
         qhAViDfyQtTLFFcvoyoT+wTO7mZWstuEyv9XPvidlyjYtxObmYZPSRDDFYVJLenYwYoA
         yxcDBjG37fTQWuoYr2cig7bqsERXkBZBswEfuUN7auTCqF2qmE6zAnUSsGSIye5lU110
         HqN27i9q7WlR1j+Sn2zN17BqcUL+KYTZwoiA0zRvzINyAtmo6bjsHHhJO9Y2AJcqzkNW
         INn5IovbKuJly36PjqiKXrWLWh6brIBo+/AxKSRzimWmMFT6F/OPgjYnspfVH9pPDjPQ
         cRmA==
X-Gm-Message-State: AC+VfDyU8FTUrqviAGvyoxP9wrN1vGARE4mjZScpLA0nk2ILCiQTtUn0
        OKQQ9DlBLZDVNTb30vPY2JTVaA==
X-Google-Smtp-Source: ACHHUZ4MlU0pdFRrWT9QBhsuI4cYeLR3QxRmEAF73ZxP7YcwsNZO8xecUtsC5xjwVTfHUJpTsK4kZg==
X-Received: by 2002:a17:902:c40c:b0:1af:f8a8:5bab with SMTP id k12-20020a170902c40c00b001aff8a85babmr4522123plk.52.1685152863998;
        Fri, 26 May 2023 19:01:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001a922d43779sm3851246plb.27.2023.05.26.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 19:01:03 -0700 (PDT)
Date:   Fri, 26 May 2023 19:01:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: Warn about 0-length and 1-element arrays
Message-ID: <202305261859.310EB2972A@keescook>
References: <20230526173921.gonna.349-kees@kernel.org>
 <c65be7a615f5cfa300289a6f251d97286c8d81e9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c65be7a615f5cfa300289a6f251d97286c8d81e9.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 06:38:27PM -0700, Joe Perches wrote:
> On Fri, 2023-05-26 at 10:39 -0700, Kees Cook wrote:
> > Fake flexible arrays have been deprecated since last millennium. Proper
> > C99 flexible arrays must be used throughout the kernel so
> > CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> > bounds checking.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > @@ -7430,6 +7430,21 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for array definition/declarations that should use flexible arrays instead
> > +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> > +		    $prevline =~ /^\+\s*(?:(?:struct|union|enum)\s+$Ident|\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> 
> I think this is overly complicated and not necessary
> 
> 		    $prevline =~ /^\+\s*$Type\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
> 
> should work no?
> 
> ($Type already includes this from @typeList):
> 	qr{struct\s+$Ident},
> 	qr{union\s+$Ident},
> 	qr{enum\s+$Ident},

Hm, I didn't when I originally tried it. I will double-check.

> 
> > +			if ($1 == '0') {
> > +				if (WARN("ZERO_LENGTH_ARRAY",
> > +					 "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
> > +				    $fix) {
> > +					$fixed[$fixlinenr - 1] =~ s/\[0\]/[]/g;
> 
> And this $fix doesn't work if the line is struct foo bar[ 0 ];
> and the use of /g is odd.

Thanks!

> Because the message is a WARN and not an ERR, please use
> "Prefer/over" and not "Use/instead of"

I will change to ERR, then. We must not use [0]-sized arrays ever.

> 
> 					$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
> > +				}
> > +			} else {
> > +				WARN("ONE_ELEMENT_ARRAY",
> > +				     "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
> > +			}
> 
> And this could have a $fix change too
> 
> 				if (WARN("ONE_ELEMENT_ARRAY",
> 					 ...) &&
> 				    $fix) {
> 					$fixed[$fixlinenr - 1] =~ s/\[\s*1\s*\]/[]/;

Almost never is it possible to only fix the struct when it's a 1-element
array (due to the impact of the size changes that be present in other
code), so I left it out.

I'll send a v3.

-Kees

-- 
Kees Cook
