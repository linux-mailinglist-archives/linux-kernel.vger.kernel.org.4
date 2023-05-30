Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7ED71717D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjE3XRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjE3XRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:17:31 -0400
Received: from mx1.supremebox.com (mx1-c1.supremebox.com [198.23.53.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A1E116;
        Tue, 30 May 2023 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bh9aJiwXlHLVy9xOFobbaK/ec+8qpwFywFgeTyhokD0=; b=EQhUwAvkCadFZrWEhduQKR7cK3
        vGuAYiFWiycWjHnYRVA/B99nKybkguIMXPHqEF5KvngSFS4cAF61cQ8sSj8h64aGToNlQENHlay6j
        iQ5PeLiR9NAHMmAgaVVt3vXCjZcuhXH6MUg6G5X29LD0jO4BWW/WA/HMFlVwysu/rzyk=;
Received: from 71-211-157-135.hlrn.qwest.net ([71.211.157.135] helo=[192.168.1.221])
        by mx1.supremebox.com with esmtpa (Exim 4.92)
        (envelope-from <opensource@jilayne.com>)
        id 1q48ah-0001cT-4r; Tue, 30 May 2023 23:17:23 +0000
Message-ID: <190d844c-be3c-efe3-c66b-525be8a7b01a@jilayne.com>
Date:   Tue, 30 May 2023 17:17:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v2 1/2] fs: udf: Replace GPL 2.0 boilerplate license
 notice with SPDX identifier
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
 <20230522005434.22133-2-bagasdotme@gmail.com>
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <20230522005434.22133-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/23 6:54 PM, Bagas Sanjaya wrote:
> The notice refers to full GPL 2.0 text on now defunct MIT FTP site [1].
> Replace it with appropriate SPDX license identifier.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Pali Rohár <pali@kernel.org>
> Link: https://web.archive.org/web/20020809115410/ftp://prep.ai.mit.edu/pub/gnu/GPL [1]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   fs/udf/balloc.c    | 6 +-----
>   fs/udf/dir.c       | 6 +-----
>   fs/udf/directory.c | 6 +-----
>   fs/udf/file.c      | 6 +-----
>   fs/udf/ialloc.c    | 6 +-----
>   fs/udf/inode.c     | 6 +-----
>   fs/udf/lowlevel.c  | 6 +-----
>   fs/udf/misc.c      | 6 +-----
>   fs/udf/namei.c     | 6 +-----
>   fs/udf/partition.c | 6 +-----
>   fs/udf/super.c     | 6 +-----
>   fs/udf/symlink.c   | 6 +-----
>   fs/udf/truncate.c  | 6 +-----
>   fs/udf/unicode.c   | 6 +-----
>   14 files changed, 14 insertions(+), 70 deletions(-)
>
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index 14b9db4c80f03f..ab3ffc355949dc 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * balloc.c
>    *
> @@ -5,11 +6,6 @@
>    *	Block allocation handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1999-2001 Ben Fennema
>    *  (C) 1999 Stelias Computing Inc
>    *
> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
> index 212393b12c2266..f6533f93851b95 100644
> --- a/fs/udf/dir.c
> +++ b/fs/udf/dir.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * dir.c
>    *
> @@ -5,11 +6,6 @@
>    *  Directory handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998-2004 Ben Fennema
>    *
>    * HISTORY

In these first two patches you have retained the word "COPYRIGHT" but...
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 654536d2b60976..1c775e072b2fef 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -1,14 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * directory.c
>    *
>    * PURPOSE
>    *	Directory related functions
>    *
> - * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
>    */
>   
>   #include "udfdecl.h"
In this patch (as well as the last one below), you have removed the word 
"COPYRIGHT" - I'm not sure having that word or not makes any meaningful 
difference (I'd lean toward removing), but either way, I think it should 
be consistent

> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 8238f742377bab..b871b85457e5bb 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * file.c
>    *
> @@ -5,11 +6,6 @@
>    *  File handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *  This file is distributed under the terms of the GNU General Public
> - *  License (GPL). Copies of the GPL can be obtained from:
> - *    ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *  Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998-1999 Dave Boynton
>    *  (C) 1998-2004 Ben Fennema
>    *  (C) 1999-2000 Stelias Computing Inc
> diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
> index 8d50121778a57d..5f7ac8c8479873 100644
> --- a/fs/udf/ialloc.c
> +++ b/fs/udf/ialloc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * ialloc.c
>    *
> @@ -5,11 +6,6 @@
>    *	Inode allocation handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998-2001 Ben Fennema
>    *
>    * HISTORY
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 1e71e04ae8f6b9..28cdfc57d946e3 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * inode.c
>    *
> @@ -5,11 +6,6 @@
>    *  Inode handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *  This file is distributed under the terms of the GNU General Public
> - *  License (GPL). Copies of the GPL can be obtained from:
> - *    ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *  Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998 Dave Boynton
>    *  (C) 1998-2004 Ben Fennema
>    *  (C) 1999-2000 Stelias Computing Inc
> diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c
> index c87ed942d07653..9d847a7a0905dd 100644
> --- a/fs/udf/lowlevel.c
> +++ b/fs/udf/lowlevel.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * lowlevel.c
>    *
> @@ -5,11 +6,6 @@
>    *  Low Level Device Routines for the UDF filesystem
>    *
>    * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1999-2001 Ben Fennema
>    *
>    * HISTORY
> diff --git a/fs/udf/misc.c b/fs/udf/misc.c
> index 3777468d06ce58..0788593b6a1d8b 100644
> --- a/fs/udf/misc.c
> +++ b/fs/udf/misc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * misc.c
>    *
> @@ -5,11 +6,6 @@
>    *	Miscellaneous routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998 Dave Boynton
>    *  (C) 1998-2004 Ben Fennema
>    *  (C) 1999-2000 Stelias Computing Inc
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index fd20423d3ed24c..49e1e0fe3feeb2 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * namei.c
>    *
> @@ -5,11 +6,6 @@
>    *      Inode name handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *      This file is distributed under the terms of the GNU General Public
> - *      License (GPL). Copies of the GPL can be obtained from:
> - *              ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *      Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998-2004 Ben Fennema
>    *  (C) 1999-2000 Stelias Computing Inc
>    *
> diff --git a/fs/udf/partition.c b/fs/udf/partition.c
> index 5bcfe78d5cabe9..af877991edc13a 100644
> --- a/fs/udf/partition.c
> +++ b/fs/udf/partition.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * partition.c
>    *
> @@ -5,11 +6,6 @@
>    *      Partition handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *      This file is distributed under the terms of the GNU General Public
> - *      License (GPL). Copies of the GPL can be obtained from:
> - *              ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *      Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998-2001 Ben Fennema
>    *
>    * HISTORY
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 6304e3c5c3d969..928a04d9d9e0ad 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * super.c
>    *
> @@ -15,11 +16,6 @@
>    *    https://www.iso.org/
>    *
>    * COPYRIGHT
> - *  This file is distributed under the terms of the GNU General Public
> - *  License (GPL). Copies of the GPL can be obtained from:
> - *    ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *  Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998 Dave Boynton
>    *  (C) 1998-2004 Ben Fennema
>    *  (C) 2000 Stelias Computing Inc
> diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
> index a34c8c4e6d2109..779b5c2c75f61e 100644
> --- a/fs/udf/symlink.c
> +++ b/fs/udf/symlink.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * symlink.c
>    *
> @@ -5,11 +6,6 @@
>    *	Symlink handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1998-2001 Ben Fennema
>    *  (C) 1999 Stelias Computing Inc
>    *
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 2e7ba234bab8b8..a686c10fd709d1 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * truncate.c
>    *
> @@ -5,11 +6,6 @@
>    *	Truncate handling routines for the OSTA-UDF(tm) filesystem.
>    *
>    * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
> - *
>    *  (C) 1999-2004 Ben Fennema
>    *  (C) 1999 Stelias Computing Inc
>    *
> diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
> index 622569007b530b..ae6e809fa3aac7 100644
> --- a/fs/udf/unicode.c
> +++ b/fs/udf/unicode.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * unicode.c
>    *
> @@ -11,11 +12,6 @@
>    *	UTF-8 is explained in the IETF RFC XXXX.
>    *		ftp://ftp.internic.net/rfc/rfcxxxx.txt
>    *
> - * COPYRIGHT
> - *	This file is distributed under the terms of the GNU General Public
> - *	License (GPL). Copies of the GPL can be obtained from:
> - *		ftp://prep.ai.mit.edu/pub/gnu/GPL
> - *	Each contributing author retains all rights to their own work.
>    */
>   
>   #include "udfdecl.h"

