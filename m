Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B635FBAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJKTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJKTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:01:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1F85A9E;
        Tue, 11 Oct 2022 12:00:59 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 53BD61C33;
        Tue, 11 Oct 2022 19:00:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 53BD61C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665514859; bh=eeNjJSKPOPDhILZEGRPPWUGf0HrxtRLOdknTiYDbf7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FE+SaK+SskDHqsXJemfqmCsPhSonSqHZV4VN8tcHoexnybb844HRCUknkdrSuMAsR
         wEY0DmHDphPTjgag1vzzKettIxdbw7F5Fr1L+sc87WQhF8R3m8QI6r0x5Za8oX1ss1
         mKF4yOAS5TfJzDOyDjI20d9HQZdsh0RZk+J9b60J4oQ4lo4+TFh3awsxY97AHrDv20
         vFl31zug0pAOclmrYrysY+ks37BIY/rV+OM97LEf7buRo1PtRJeIvzcikzqyBdDUgE
         YebppQwwXXIDlwHg5xMFgSaVyrAcvNGW2K32CfPNnc77B3FtZ1DJAxroamJ0NM3Rmk
         bqi2wN72Jdviw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 6/6] docs: decruft Documentation/conf.py
Date:   Tue, 11 Oct 2022 13:00:47 -0600
Message-Id: <20221011190047.749145-7-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221011190047.749145-1-corbet@lwn.net>
References: <20221011190047.749145-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ancient support for the Sphinx "classic" theme; everybody will
have alabaster, so that fallback is no longer needed.

While in the neighborhood: get rid of lots of useless comment lines.  They
describe the state of Sphinx options when we first created that file and
are just clutter now.

Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 181 +-----------------------------------------
 1 file changed, 2 insertions(+), 179 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 1dbf3d6a55de..6ab47833ab6c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -297,7 +297,7 @@ if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
                 html_css_files.append('theme_rtd_colors.css')
 
     except ImportError:
-        html_theme = 'classic'
+        html_theme = 'alabaster'
 
 if "DOCS_CSS" in os.environ:
     css = os.environ["DOCS_CSS"].split(" ")
@@ -313,36 +313,7 @@ if major <= 1 and minor < 8:
     for l in html_css_files:
         html_context['css_files'].append('_static/' + l)
 
-if  html_theme == 'classic':
-    html_theme_options = {
-        'rightsidebar':        False,
-        'stickysidebar':       True,
-        'collapsiblesidebar':  True,
-        'externalrefs':        False,
-
-        'footerbgcolor':       "white",
-        'footertextcolor':     "white",
-        'sidebarbgcolor':      "white",
-        'sidebarbtncolor':     "black",
-        'sidebartextcolor':    "black",
-        'sidebarlinkcolor':    "#686bff",
-        'relbarbgcolor':       "#133f52",
-        'relbartextcolor':     "white",
-        'relbarlinkcolor':     "white",
-        'bgcolor':             "white",
-        'textcolor':           "black",
-        'headbgcolor':         "#f2f2f2",
-        'headtextcolor':       "#20435c",
-        'headlinkcolor':       "#c60f0f",
-        'linkcolor':           "#355f7c",
-        'visitedlinkcolor':    "#355f7c",
-        'codebgcolor':         "#3f3f3f",
-        'codetextcolor':       "white",
-
-        'bodyfont':            "serif",
-        'headfont':            "sans-serif",
-    }
-else:
+if  html_theme == 'alabaster':
     html_theme_options = {
         'description': get_cline_version(),
         'font_size': '10pt',
@@ -352,44 +323,11 @@ else:
 
 sys.stderr.write("Using %s theme\n" % html_theme)
 
-# Theme options are theme-specific and customize the look and feel of a theme
-# further.  For a list of options available for each theme, see the
-# documentation.
-#html_theme_options = {}
-
-# Add any paths that contain custom themes here, relative to this directory.
-#html_theme_path = []
-
-# The name for this set of Sphinx documents.  If None, it defaults to
-# "<project> v<release> documentation".
-#html_title = None
-
-# A shorter title for the navigation bar.  Default is the same as html_title.
-#html_short_title = None
-
-# The name of an image file (relative to this directory) to place at the top
-# of the sidebar.
-#html_logo = None
-
-# The name of an image file (within the static path) to use as favicon of the
-# docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
-# pixels large.
-#html_favicon = None
-
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
 # so a file named "default.css" will overwrite the builtin "default.css".
 html_static_path = ['sphinx-static']
 
-# Add any extra paths that contain custom files (such as robots.txt or
-# .htaccess) here, relative to this directory. These files are copied
-# directly to the root of the documentation.
-#html_extra_path = []
-
-# If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
-# using the given strftime format.
-#html_last_updated_fmt = '%b %d, %Y'
-
 # If true, SmartyPants will be used to convert quotes and dashes to
 # typographically correct entities.
 html_use_smartypants = False
@@ -398,50 +336,6 @@ html_use_smartypants = False
 # Note that the RTD theme ignores this
 html_sidebars = { '**': ["about.html", 'searchbox.html', 'localtoc.html', 'sourcelink.html']}
 
-# Additional templates that should be rendered to pages, maps page names to
-# template names.
-#html_additional_pages = {}
-
-# If false, no module index is generated.
-#html_domain_indices = True
-
-# If false, no index is generated.
-#html_use_index = True
-
-# If true, the index is split into individual pages for each letter.
-#html_split_index = False
-
-# If true, links to the reST sources are added to the pages.
-#html_show_sourcelink = True
-
-# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
-#html_show_sphinx = True
-
-# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
-#html_show_copyright = True
-
-# If true, an OpenSearch description file will be output, and all pages will
-# contain a <link> tag referring to it.  The value of this option must be the
-# base URL from which the finished HTML is served.
-#html_use_opensearch = ''
-
-# This is the file name suffix for HTML files (e.g. ".xhtml").
-#html_file_suffix = None
-
-# Language to be used for generating the HTML full-text search index.
-# Sphinx supports the following languages:
-#   'da', 'de', 'en', 'es', 'fi', 'fr', 'h', 'it', 'ja'
-#   'nl', 'no', 'pt', 'ro', 'r', 'sv', 'tr'
-#html_search_language = 'en'
-
-# A dictionary with options for the search language support, empty by default.
-# Now only 'ja' uses this config value
-#html_search_options = {'type': 'default'}
-
-# The name of a javascript file (relative to the configuration directory) that
-# implements a search results scorer. If empty, the default will be used.
-#html_search_scorer = 'scorer.js'
-
 # Output file base name for HTML help builder.
 htmlhelp_basename = 'TheLinuxKerneldoc'
 
@@ -583,19 +477,6 @@ texinfo_documents = [
      'Miscellaneous'),
 ]
 
-# Documents to append as an appendix to all manuals.
-#texinfo_appendices = []
-
-# If false, no module index is generated.
-#texinfo_domain_indices = True
-
-# How to display URL addresses: 'footnote', 'no', or 'inline'.
-#texinfo_show_urls = 'footnote'
-
-# If true, do not generate a @detailmenu in the "Top" node's menu.
-#texinfo_no_detailmenu = False
-
-
 # -- Options for Epub output ----------------------------------------------
 
 # Bibliographic Dublin Core info.
@@ -604,67 +485,9 @@ epub_author = author
 epub_publisher = author
 epub_copyright = copyright
 
-# The basename for the epub file. It defaults to the project name.
-#epub_basename = project
-
-# The HTML theme for the epub output. Since the default themes are not
-# optimized for small screen space, using the same theme for HTML and epub
-# output is usually not wise. This defaults to 'epub', a theme designed to save
-# visual space.
-#epub_theme = 'epub'
-
-# The language of the text. It defaults to the language option
-# or 'en' if the language is not set.
-#epub_language = ''
-
-# The scheme of the identifier. Typical schemes are ISBN or URL.
-#epub_scheme = ''
-
-# The unique identifier of the text. This can be a ISBN number
-# or the project homepage.
-#epub_identifier = ''
-
-# A unique identification for the text.
-#epub_uid = ''
-
-# A tuple containing the cover image and cover page html template filenames.
-#epub_cover = ()
-
-# A sequence of (type, uri, title) tuples for the guide element of content.opf.
-#epub_guide = ()
-
-# HTML files that should be inserted before the pages created by sphinx.
-# The format is a list of tuples containing the path and title.
-#epub_pre_files = []
-
-# HTML files that should be inserted after the pages created by sphinx.
-# The format is a list of tuples containing the path and title.
-#epub_post_files = []
-
 # A list of files that should not be packed into the epub file.
 epub_exclude_files = ['search.html']
 
-# The depth of the table of contents in toc.ncx.
-#epub_tocdepth = 3
-
-# Allow duplicate toc entries.
-#epub_tocdup = True
-
-# Choose between 'default' and 'includehidden'.
-#epub_tocscope = 'default'
-
-# Fix unsupported image types using the Pillow.
-#epub_fix_images = False
-
-# Scale large images.
-#epub_max_image_width = 0
-
-# How to display URL addresses: 'footnote', 'no', or 'inline'.
-#epub_show_urls = 'inline'
-
-# If false, no index is generated.
-#epub_use_index = True
-
 #=======
 # rst2pdf
 #
-- 
2.37.2

