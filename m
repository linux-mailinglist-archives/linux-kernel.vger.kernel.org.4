Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608655EB764
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiI0CK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiI0CK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:10:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F291D38;
        Mon, 26 Sep 2022 19:10:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r62so4317091pgr.12;
        Mon, 26 Sep 2022 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fYBffQSM2i+9QGjPyC0nAW4u5emJOvkPCeCMQMjuXZU=;
        b=nN7gOaf+1x6pj2PGcmMVFr/Ou1YdxJKRzMciyT2hMhRm6IqzontFRPT0INguTXaoJh
         5c2c8c4Yl/GCB+L5hDuAIJ6Rdg6NHCEijidkLVlLE5PzlPmNzgXYK7ynZRAaBQxa2FJX
         j76YbUOX32VHVBUpyiH+GDR9Cokqx1m4ht8jLlqkNQcY/bRK4T7R1tcu1VdYIVdNmOTo
         47YYfckn8HddDapahpusEnM7vAaWNRWkbuLDO4zABl/UChdTYE9nsc0fA9T3//xC6PBv
         e2fXz3Xo4tNZAFfSfPsNtb+NBeJBcE9Onjxk3fXRkX8UMl1jOYNfBp5vTq2eFwfg8Zs6
         zu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fYBffQSM2i+9QGjPyC0nAW4u5emJOvkPCeCMQMjuXZU=;
        b=v6y2greDP8tmpK2W6bYRsoF2Z4lz2VTLXCBqPaU00NlugU2ioYBN9ELpKUH0e3KAu8
         xWrrc9FnGbdEeJOXhCimQJg/Byo1KYtzYqDiFBuNrwubyhjNYc4EA0tkUAPwHFPvMx4f
         qQ2KE8xKyA8gKYyfJq/yMhJrx+/F76kHnDSaSsenR+wgFyz9zvC7rjnLRMQTwZHaS+/D
         D+ob4EAlj8Wgioaqu3Hdt7lxDu1ycbjz2mdySgP4QbbDnnDn/RI3yIV4r8B6rwqkKXRN
         AXyD+YRU7Bk3jKuKHcvN4UjUvnF2HKlEJbrPbgZRf1hWAQaCLIcmlE/OJXmJsChIotsL
         w7oQ==
X-Gm-Message-State: ACrzQf11pFHSBLse7bWg+CWKUiCuqwqTAV+bu9U1U1SGQgBx/G5jFxZD
        8aAa2MUjw3dWwVRnN6Ij6fs=
X-Google-Smtp-Source: AMsMyM6Jzo4YtMWiAU/8Neiwxfp9Num3a72wV3ezSFpFa5VbxauFC+poIfYTZFf3yLAR1MpLIbmjvQ==
X-Received: by 2002:a05:6a00:854:b0:542:4254:17f6 with SMTP id q20-20020a056a00085400b00542425417f6mr26636751pfk.47.1664244655148;
        Mon, 26 Sep 2022 19:10:55 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a15-20020aa78e8f000000b00540f3ac5fb8sm217566pfr.69.2022.09.26.19.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 19:10:54 -0700 (PDT)
Message-ID: <2429b482-089e-8678-2c10-176cab612426@gmail.com>
Date:   Tue, 27 Sep 2022 11:10:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] docs/doc-guide: Add documentation on SPHINX_IMGMATH
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <a67e3279-6bc7-ee2c-2b49-9275252460b0@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <a67e3279-6bc7-ee2c-2b49-9275252460b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 19:08:05 +0900, Akira Yokosawa wrote:
> Now that building html docs with math expressions does not need texlive
> packages, remove the note on the requirement in the "Sphinx Install"
> section.
> 
> Instead, add sections of "Math Expressions in HTML" and "Choice of Math
> Renderer".
> Describe the effect of setting SPHINX_IMGMATH in the latter section.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
Gentle ping.

Jon, is there anything I need to do for improving this?

        Thanks, Akira

> ---
> Hi,
> 
> This is a follow-up of the mathjax patch set [1].
> In the thread, I mentioned my plan to add support of SVG images for
> imgmath in reply to Randy.
> 
> I've not convinced myself if adding code for checking dvisvgm's
> dependencies in conf.py is the right thing to do.
> 
> My reservation comes from:
> 
>  1) Any lack in dependency list can result in false-positive of
>     enabling SVG and a build error of htmldocs with cryptic looking
>     error messages.
>  2) Dependency of dvisvgm may change in future releases of Sphinx
>     and/or dvisvgm as well as other texlive packages.
> 
> So I'm sending this documentation update describing the current state
> of affairs for the 6.1 merge window.
> 
> I might change my mind and revisit the SVG part if I hear people's
> interests in it.
> 
> For the moment, SVG math images can be enabled by adding:
> 
>     SPHINXOPTS="-D imgmath_image_format='svg'"
> 
> to the "make htmldocs" command line.
> 
> [1]: https://lore.kernel.org/all/9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com/
> 
>         Thanks, Akira
> --
>  Documentation/doc-guide/sphinx.rst | 57 +++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 1228b85f6f77..c708cec889af 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -48,10 +48,6 @@ or ``virtualenv``, depending on how your distribution packaged Python 3.
>        on the Sphinx version, it should be installed separately,
>        with ``pip install sphinx_rtd_theme``.
>  
> -   #) Some ReST pages contain math expressions. Due to the way Sphinx works,
> -      those expressions are written using LaTeX notation. It needs texlive
> -      installed with amsfonts and amsmath in order to evaluate them.
> -
>  In summary, if you want to install Sphinx version 2.4.4, you should do::
>  
>         $ virtualenv sphinx_2.4.4
> @@ -86,6 +82,27 @@ Depending on the distribution, you may also need to install a series of
>  ``texlive`` packages that provide the minimal set of functionalities
>  required for ``XeLaTeX`` to work.
>  
> +Math Expressions in HTML
> +------------------------
> +
> +Some ReST pages contain math expressions. Due to the way Sphinx works,
> +those expressions are written using LaTeX notation.
> +There are two options for Sphinx to render math expressions in html output.
> +One is an extension called `imgmath`_ which converts math expressions into
> +images and embeds them in html pages.
> +The other is an extension called `mathjax`_ which delegates math rendering
> +to JavaScript capable web browsers.
> +The former was the only option for pre-6.1 kernel documentation and it
> +requires quite a few texlive packages including amsfonts and amsmath among
> +others.
> +
> +Since kernel release 6.1, html pages with math expressions can be built
> +without installing any texlive packages. See `Choice of Math Renderer`_ for
> +further info.
> +
> +.. _imgmath: https://www.sphinx-doc.org/en/master/usage/extensions/math.html#module-sphinx.ext.imgmath
> +.. _mathjax: https://www.sphinx-doc.org/en/master/usage/extensions/math.html#module-sphinx.ext.mathjax
> +
>  .. _sphinx-pre-install:
>  
>  Checking for Sphinx dependencies
> @@ -164,6 +181,38 @@ To remove the generated documentation, run ``make cleandocs``.
>  	  as well would improve the quality of images embedded in PDF
>  	  documents, especially for kernel releases 5.18 and later.
>  
> +Choice of Math Renderer
> +-----------------------
> +
> +Since kernel release 6.1, mathjax works as a fallback math renderer for
> +html output.\ [#sph1_8]_
> +
> +Math renderer is chosen depending on available commands as shown below:
> +
> +.. table:: Math Renderer Choices for HTML
> +
> +    ============= ================= ============
> +    Math renderer Required commands Image format
> +    ============= ================= ============
> +    imgmath       latex, dvipng     PNG (raster)
> +    mathjax
> +    ============= ================= ============
> +
> +The choice can be overridden by setting an environment variable
> +``SPHINX_IMGMATH`` as shown below:
> +
> +.. table:: Effect of Setting ``SPHINX_IMGMATH``
> +
> +    ====================== ========
> +    Setting                Renderer
> +    ====================== ========
> +    ``SPHINX_IMGMATH=yes`` imgmath
> +    ``SPHINX_IMGMATH=no``  mathjax
> +    ====================== ========
> +
> +.. [#sph1_8] Fallback of math renderer requires Sphinx >=1.8.
> +
> +
>  Writing Documentation
>  =====================
>  
> 
> base-commit: 7ebeef22dcc2c3db83dcd1e8292744cf29c1859f
