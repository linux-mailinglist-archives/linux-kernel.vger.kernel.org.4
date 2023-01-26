Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F9F67CD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjAZOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAZOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:16:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC441097
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:16:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bk15so5357867ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flwiW/xi72yKzHSqPW2Y3gpNbThE+7pF0t3EWtl4bTY=;
        b=jN8TuaHh65R0CGmw8VIIjYWOzwSVI9M9W5qy9Kl+nJTMMq7V5lcwTBeRkLF0JehNSc
         4ooTEyvuCbUkFUFWVPGdLpv2/6u7uoLNm1HX5uh8Vym5AYKkA4DskH9cmazclvzN9PQb
         hrgSUqnwzejScwKA8O9eE4VTQivc3Fusx6FoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flwiW/xi72yKzHSqPW2Y3gpNbThE+7pF0t3EWtl4bTY=;
        b=vqkpdKb23wbz/p10M16OoDqZ5KjsZwLg3AsPxjbuk8M0hdXRJgyctL3MJvLgHKecME
         ReaGxwIj7Zdlp7f8qxaVJ3ucNo6zFZjzvbssD7peeC729nw8zkJlDrqLJVQ3uNkCQClO
         Z39JWB2KSzT3U45HTLbejKiGoYGtOecWoI8fLV1SADw/FEUWRYmP7act6j01Yt7zYgVq
         obIqI2/xRrUnop6K7Yx9VO/fox5mBMu0dkQ7UKW786BpSXcJQUido4EFXbx8slzK9I0B
         ps9leET42LW5hIQewZES6A0UH6lvRx0u46Io8DObYh0OPcdDtEzHiSV1x6KGSGPlKWA1
         J9IA==
X-Gm-Message-State: AFqh2kpCyfZMJm4qBI+EqZWGrjq3zMhBpydMEN3HCYw3PRXdTDNUoXpa
        JwB0+YtmoIN5TmDmtTNkWaZsqF4gIcTV+Nc6smTzRw==
X-Google-Smtp-Source: AMrXdXtbG+I0/IvzKg+JicnlRUsGUccM/nFTfXRJLbvMyPyffLDZKCISRrrJp6Zit6/bxr3CYGgdIlH8oiqDwmVlqX0=
X-Received: by 2002:a17:906:6a8e:b0:86e:3764:4f80 with SMTP id
 p14-20020a1709066a8e00b0086e37644f80mr3653187ejr.239.1674742565043; Thu, 26
 Jan 2023 06:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20230109010023.20719-1-rdunlap@infradead.org>
In-Reply-To: <20230109010023.20719-1-rdunlap@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 26 Jan 2023 15:15:54 +0100
Message-ID: <CAJfpegv2DW8toDQ_aUUC_KeE8X=oTv37BjXw3u_8HL-Ky7ba0g@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix all W=1 kernel-doc warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 02:00, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use correct function name in kernel-doc notation. (1)
> Don't use "/**" to begin non-kernel-doc comments. (3)
>
> Fixes these warnings:
>
> fs/fuse/cuse.c:272: warning: expecting prototype for cuse_parse_dev_info(). Prototype was for cuse_parse_devinfo() instead
> fs/fuse/dev.c:212: warning: expecting prototype for A new request is available, wake fiq(). Prototype was for fuse_dev_wake_and_unlock() instead
> fs/fuse/dir.c:149: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Mark the attributes as stale due to an atime change.  Avoid the invalidate if
> fs/fuse/file.c:656: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * In case of short read, the caller sets 'pos' to the position of
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>

Applied, thanks.

Miklos
