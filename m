Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A938E5BA9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiIPKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiIPKI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:08:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA45AB41E;
        Fri, 16 Sep 2022 03:08:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id iw17so21010366plb.0;
        Fri, 16 Sep 2022 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=o4dNK8sODyJBDE21/k1sZDBLAnfZVMB1+5ooUJQHkAA=;
        b=J0VYXSd+C84QGhK27beRSQzeBVKtXzs2wSW/W6r1+IHs1GeuOKnsObida6F1x0mfHV
         IMXdNvUCh+aarVyWDJ6lwSFe9jBZPWssGdSmSxo6NtqS4NCZ6h6pQC2ckoypt4w4QIyj
         2hQ86wMC9YcQg9I4yzhP+nnicewsV1CmurYcsCz8Sq3wsPZRWST8OGLrugoPAkztL7uo
         c8LS7J+nLOkAEq1c1r8BZOSJ8ENKMYPpu/bSa5AsF804LnMQio779Gvriq1RKI9/oqWO
         rrrTL4wgYgfxuUTF7bhfsH6YD+lAXGRgDtUF466jQL2UAqVk+VzrOAmb+w+MHg1VkkwE
         93og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=o4dNK8sODyJBDE21/k1sZDBLAnfZVMB1+5ooUJQHkAA=;
        b=ko+KoGMlVY+nJ5+NM7mBW1VeAo+568+L1ec42CR2phdDexBK+hipSi+f8+ZzPoKpIk
         McTn3o8cS1cqX/WXvr35hDEj9Wk33obGc+HM8yoDdgYt9BdJnuiV4sMUKUNgpbHMiKtf
         319h0TRyVPEzYPHmi3Q9JLfmEj7paDm1Xw9sN0Ym6Sj7bPrcfiU1Lz8wtZGxzMPgY75g
         7Best9zjcpOJx/uANIQ1d+YsDiBXzyCbe6yapqHt7Ox0NLti8xlZDG/fSE2tIr12BS69
         0c8XUQBvDE4P7AibAxLVH4H5mAo1cDshAtCT7ERAgl8WibGPlcQoKzLoQJBxXhB+/Ues
         cYLQ==
X-Gm-Message-State: ACrzQf2MBai0irAN5lIMg2BFzVThyIT3c56pjz7pq3phieDZ1hG9yrJx
        FyOfie23pDx050zK230JaDI=
X-Google-Smtp-Source: AMsMyM4qpIYXnlQnQD91X+fdX76pKdrEkAGhw6YVOpWoCxw/+QWgDPnnFBfgR2FMPD6EN4GM0tZl1g==
X-Received: by 2002:a17:90a:5a02:b0:203:1640:2da9 with SMTP id b2-20020a17090a5a0200b0020316402da9mr4517252pjd.245.1663322889278;
        Fri, 16 Sep 2022 03:08:09 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902778200b0016c50179b1esm14375267pll.152.2022.09.16.03.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 03:08:08 -0700 (PDT)
Message-ID: <a67e3279-6bc7-ee2c-2b49-9275252460b0@gmail.com>
Date:   Fri, 16 Sep 2022 19:08:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs/doc-guide: Add documentation on SPHINX_IMGMATH
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that building html docs with math expressions does not need texlive
packages, remove the note on the requirement in the "Sphinx Install"
section.

Instead, add sections of "Math Expressions in HTML" and "Choice of Math
Renderer".
Describe the effect of setting SPHINX_IMGMATH in the latter section.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
Hi,

This is a follow-up of the mathjax patch set [1].
In the thread, I mentioned my plan to add support of SVG images for
imgmath in reply to Randy.

I've not convinced myself if adding code for checking dvisvgm's
dependencies in conf.py is the right thing to do.

My reservation comes from:

 1) Any lack in dependency list can result in false-positive of
    enabling SVG and a build error of htmldocs with cryptic looking
    error messages.
 2) Dependency of dvisvgm may change in future releases of Sphinx
    and/or dvisvgm as well as other texlive packages.

So I'm sending this documentation update describing the current state
of affairs for the 6.1 merge window.

I might change my mind and revisit the SVG part if I hear people's
interests in it.

For the moment, SVG math images can be enabled by adding:

    SPHINXOPTS="-D imgmath_image_format='svg'"

to the "make htmldocs" command line.

[1]: https://lore.kernel.org/all/9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com/

        Thanks, Akira
--
 Documentation/doc-guide/sphinx.rst | 57 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 1228b85f6f77..c708cec889af 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -48,10 +48,6 @@ or ``virtualenv``, depending on how your distribution packaged Python 3.
       on the Sphinx version, it should be installed separately,
       with ``pip install sphinx_rtd_theme``.
 
-   #) Some ReST pages contain math expressions. Due to the way Sphinx works,
-      those expressions are written using LaTeX notation. It needs texlive
-      installed with amsfonts and amsmath in order to evaluate them.
-
 In summary, if you want to install Sphinx version 2.4.4, you should do::
 
        $ virtualenv sphinx_2.4.4
@@ -86,6 +82,27 @@ Depending on the distribution, you may also need to install a series of
 ``texlive`` packages that provide the minimal set of functionalities
 required for ``XeLaTeX`` to work.
 
+Math Expressions in HTML
+------------------------
+
+Some ReST pages contain math expressions. Due to the way Sphinx works,
+those expressions are written using LaTeX notation.
+There are two options for Sphinx to render math expressions in html output.
+One is an extension called `imgmath`_ which converts math expressions into
+images and embeds them in html pages.
+The other is an extension called `mathjax`_ which delegates math rendering
+to JavaScript capable web browsers.
+The former was the only option for pre-6.1 kernel documentation and it
+requires quite a few texlive packages including amsfonts and amsmath among
+others.
+
+Since kernel release 6.1, html pages with math expressions can be built
+without installing any texlive packages. See `Choice of Math Renderer`_ for
+further info.
+
+.. _imgmath: https://www.sphinx-doc.org/en/master/usage/extensions/math.html#module-sphinx.ext.imgmath
+.. _mathjax: https://www.sphinx-doc.org/en/master/usage/extensions/math.html#module-sphinx.ext.mathjax
+
 .. _sphinx-pre-install:
 
 Checking for Sphinx dependencies
@@ -164,6 +181,38 @@ To remove the generated documentation, run ``make cleandocs``.
 	  as well would improve the quality of images embedded in PDF
 	  documents, especially for kernel releases 5.18 and later.
 
+Choice of Math Renderer
+-----------------------
+
+Since kernel release 6.1, mathjax works as a fallback math renderer for
+html output.\ [#sph1_8]_
+
+Math renderer is chosen depending on available commands as shown below:
+
+.. table:: Math Renderer Choices for HTML
+
+    ============= ================= ============
+    Math renderer Required commands Image format
+    ============= ================= ============
+    imgmath       latex, dvipng     PNG (raster)
+    mathjax
+    ============= ================= ============
+
+The choice can be overridden by setting an environment variable
+``SPHINX_IMGMATH`` as shown below:
+
+.. table:: Effect of Setting ``SPHINX_IMGMATH``
+
+    ====================== ========
+    Setting                Renderer
+    ====================== ========
+    ``SPHINX_IMGMATH=yes`` imgmath
+    ``SPHINX_IMGMATH=no``  mathjax
+    ====================== ========
+
+.. [#sph1_8] Fallback of math renderer requires Sphinx >=1.8.
+
+
 Writing Documentation
 =====================
 

base-commit: 7ebeef22dcc2c3db83dcd1e8292744cf29c1859f
-- 
2.25.1

