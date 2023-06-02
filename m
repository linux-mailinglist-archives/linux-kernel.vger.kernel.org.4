Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B7720662
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjFBPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFBPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:38:14 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272110C8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:37:51 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QXnFC0cSVzMpncH;
        Fri,  2 Jun 2023 17:37:35 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QXnF773rkzMq0fs;
        Fri,  2 Jun 2023 17:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1685720254;
        bh=pmg5REnYahOAeRBIXRcdMqruvN/VKQG83JV72Nx/0eM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=u2I2lq5CiYrmhn2vQqUA4w+jgY/uqSy97lFZP9ORKu2gcdykyjDg7OH4ViXRcDRA5
         ke3Gs2ZXYAnhRNbdVzkn8t0gZgtwwNu2oZyoGMjcaoBKKQg/XtVALqtqHQ+k7yvyBp
         +dOM3GM9HroiCCeyG8M2OZNBXkyG9s6k61rrII3E=
Message-ID: <d8afcd26-af64-b062-8e40-b59eff9b4180@digikod.net>
Date:   Fri, 2 Jun 2023 17:37:31 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
Content-Language: en-US
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        ojeda@kernel.org, danny@kdrag0n.dev
Cc:     masahiroy@kernel.org, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, joe@perches.com, linux@rasmusvillemoes.dk,
        willy@infradead.org, mailhol.vincent@wanadoo.fr
References: <20230601075333.14021-1-ihuguet@redhat.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230601075333.14021-1-ihuguet@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, thanks!

Acked-by: Mickaël Salaün <mic@digikod.net>

It would be nice to have a script to check files and output a diff if 
they are not in line with this configuration. That could also be used to 
measure how many files are compliant with these rules, and add this 
stats in the commit message.

For some reasons, maintainers may want to exclude some files from these 
constraints. It would be useful to add some documentation explaining how 
to do it.


On 01/06/2023 09:53, Íñigo Huguet wrote:
> EditorConfig is a specification to define the most basic code formatting
> stuff, and it's supported by many editors and IDEs, either directly or
> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> 
> It allows to define formatting style related to indentation, charset,
> end of lines and trailing whitespaces. It also allows to apply different
> formats for different files based on wildcards, so for example it is
> possible to apply different configs to *.{c,h}, *.py and *.rs.
> 
> In linux project, defining a .editorconfig might help to those people
> that work on different projects with different indentation styles, so
> they cannot define a global style. Now they will directly see the
> correct indentation on every fresh clone of the project.
> 
> See https://editorconfig.org
> 
> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> ---
> v2:
> - added special rule for patch files so it doesn't remove
>    trailing whitespaces, making them unusable.
> v3:
> - moved all rules from [*] section to all the individual
>    sections so they doesn't affect to unexpected files.
> - added some extensions and files from a patch from Danny
>    Lin that didn't get to be merged:
>    https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
>    However, the following file types hasn't been added
>    because they don't have a clear common style:
>    rst,pl,cocci,tc,bconf,svg,xsl,manual pages
> v4:
> - Analyzed with a script the styles used by different file types
> - Added rules for awd, dts, dtsi, dtso, s, S
> - Removed rules for rb and pm that has very few files in the tree
> - Removed rules for tools/perf/scripts/*/bin/*
> - Changed rules for py to better match the 2 styles that are present in
>    the tree: 4 spaces by default and tabs for files in subdirectories
>    tools/{perf,power,rcu,testing/kunit}
> ---
>   .editorconfig                          | 32 ++++++++++++++++++++++++++
>   .gitignore                             |  1 +
>   Documentation/process/4.Coding.rst     |  4 ++++
>   Documentation/process/coding-style.rst |  4 ++++
>   4 files changed, 41 insertions(+)
>   create mode 100644 .editorconfig
> 
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 000000000000..854773350cc5
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +root = true
> +
> +[{*.{awk,c,dts,dtsi,dtso,h,mk,s,S},Kconfig,Makefile,Makefile.*}]
> +charset = utf-8
> +end_of_line = lf
> +trim_trailing_whitespace = true
> +insert_final_newline = true
> +indent_style = tab
> +indent_size = 8
> +
> +[*.{json,py,rs}]
> +charset = utf-8
> +end_of_line = lf
> +trim_trailing_whitespace = true
> +insert_final_newline = true
> +indent_style = space
> +indent_size = 4
> +
> +# this must be below the general *.py to overwrite it
> +[tools/{perf,power,rcu,testing/kunit}/**.py,]
> +indent_style = tab
> +indent_size = 8
> +
> +[*.yaml]
> +charset = utf-8
> +end_of_line = lf
> +trim_trailing_whitespace = unset
> +insert_final_newline = true
> +indent_style = space
> +indent_size = 2
> diff --git a/.gitignore b/.gitignore
> index 70ec6037fa7a..e4b3fe1d029b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -100,6 +100,7 @@ modules.order
>   #
>   !.clang-format
>   !.cocciconfig
> +!.editorconfig
>   !.get_maintainer.ignore
>   !.gitattributes
>   !.gitignore
> diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
> index 1f0d81f44e14..c2046dec0c2f 100644
> --- a/Documentation/process/4.Coding.rst
> +++ b/Documentation/process/4.Coding.rst
> @@ -66,6 +66,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
>   See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
>   for more details.
>   
> +Some basic editor settings, such as indentation and line endings, will be
> +set automatically if you are using an editor that is compatible with
> +EditorConfig. See the official EditorConfig website for more information:
> +https://editorconfig.org/
>   
>   Abstraction layers
>   ******************
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 007e49ef6cec..ec96462fa8be 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -735,6 +735,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
>   See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
>   for more details.
>   
> +Some basic editor settings, such as indentation and line endings, will be
> +set automatically if you are using an editor that is compatible with
> +EditorConfig. See the official EditorConfig website for more information:
> +https://editorconfig.org/
>   
>   10) Kconfig configuration files
>   -------------------------------
