Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6A744213
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjF3SSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjF3SSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:18:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67243AA7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:18:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262cc036fa4so1115209a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688149118; x=1690741118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JhOMq1HY0NT+4aYW+8kI5Q1oNJexqE5nfoCKy371/0I=;
        b=Gq+GLofs0fp24id2Rgm0KWaS7yy/ePwR72VADTUhmSlnDfIxIGhdHsbAu/WT7ihYV7
         JX9M4pvCiA8Za5u4qzsJHf/tj3Qguo0Q4zPG2hndNMm+pfxnJk2i3NIzC1I1n2e9ppP7
         xy52sibmznojoD7vpL7Mh7VecksBdNUvAznz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149118; x=1690741118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhOMq1HY0NT+4aYW+8kI5Q1oNJexqE5nfoCKy371/0I=;
        b=c+v0gLTJGE2tRC2HZos4K8kpQgIKJZ47OjP2iwz9pbFlJR5C8BNSHhgE7e684isdoZ
         VWVV3tSsUmmh9ilFSvx+nAVWRhD6uBJxpNbJo8PIwhlSrJw75h69a2UclnqhmSGEAvkD
         4TqsP7a66++nB+BEVQw/UgYPRlF9qT1+JprhXa+Ph+lE6P+1jZM0IjXCm+/vJrf7Owgh
         hHTE/sBVyNUttV3A7XG8qD1pzV7y72JWdcz/iFe6wK5AYrn1rEmS/QXXqZsji/CPd1Cb
         kFsr0cBVlOqLvEemQqWq2ujHyGEBgmAHPYyGq3Ppd3idVWlij7n7oPFNTIGxrKcXRXvn
         +H7g==
X-Gm-Message-State: ABy/qLauQYm+7DQBzBYnoxt443b+1Hd8MMA2bZW0b1EAOcLqkdgPsWBe
        Fe/rNUwYFIvutYpwHCHx3bLnsg==
X-Google-Smtp-Source: APBJJlEHl8gDvbHbgn5QL6/rpYZwgiEppjuCacYsWNgW/8HmN0RO+TJlaEelpIK+MpO8GapiFgmBcw==
X-Received: by 2002:a17:90a:ff03:b0:263:1213:df3b with SMTP id ce3-20020a17090aff0300b002631213df3bmr2628809pjb.11.1688149118116;
        Fri, 30 Jun 2023 11:18:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a6c8f00b00260cce91d20sm11774659pjj.33.2023.06.30.11.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:18:37 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:18:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, corbet@lwn.net, workflows@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: security-bugs.rst: clarify CVE
 handling
Message-ID: <202306301114.E199B136@keescook>
References: <2023063020-throat-pantyhose-f110@gregkh>
 <2023063022-retouch-kerosene-7e4a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023063022-retouch-kerosene-7e4a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:14:21AM +0200, Greg Kroah-Hartman wrote:
> The kernel security team does NOT assign CVEs, so document that properly
> and provide the "if you want one, ask MITRE for it" response that we
> give on a weekly basis in the document, so we don't have to constantly
> say it to everyone who asks.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/process/security-bugs.rst | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
> index f12ac2316ce7..8b80e1eb7d79 100644
> --- a/Documentation/process/security-bugs.rst
> +++ b/Documentation/process/security-bugs.rst
> @@ -79,13 +79,10 @@ not contribute to actually fixing any potential security problems.
>  CVE assignment
>  --------------
>  
> -The security team does not normally assign CVEs, nor do we require them
> -for reports or fixes, as this can needlessly complicate the process and
> -may delay the bug handling. If a reporter wishes to have a CVE identifier
> -assigned ahead of public disclosure, they will need to contact the private
> -linux-distros list, described above. When such a CVE identifier is known
> -before a patch is provided, it is desirable to mention it in the commit
> -message if the reporter agrees.
> +The security team does not assign CVEs, nor do we require them for
> +reports or fixes, as this can needlessly complicate the process and may
> +delay the bug handling.  If a reporter wishes to have a CVE identifier
> +assigned, they should contact MITRE directly.

Hmm. The language about "assigned ahead of public disclosure" was added
intentionally due to trouble we'd had with coordination when a CVE was
needed, etc. Additionally, it IS preferred to have a CVE in a patch when
it IS known ahead of time, so I think that should be kept. How about
this:


diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 82e29837d589..2f4060d49b31 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -81,13 +81,12 @@ the email Subject line with "[vs]" as described in the linux-distros wiki:
 CVE assignment
 --------------
 
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
+The security team does not assign CVEs, nor do we require them for reports
+or fixes, as this can needlessly complicate the process and may delay
+the bug handling. If a reporter wishes to have a CVE identifier assigned
+ahead of public disclosure, they will need to contact MITRE directly.
+When such a CVE identifier is known before a patch is provided, it is
+desirable to mention it in the commit message if the reporter agrees.
 
 Non-disclosure agreements
 -------------------------

-- 
Kees Cook
