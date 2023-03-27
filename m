Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B606CA2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjC0LmR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjC0LmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:42:16 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F41734
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:42:12 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id eg48so34733244edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679917330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6dyPy0r+bhQktbJFAP7TBzvmKU4IsVgnhjb9K9FxxA=;
        b=gRsp9ewRuVx8Q4FmoB/cdV73/bt3xO87EpmOMT0lreBJKSNwVDuIZcAH36DcbTkz0X
         zY9EGK6YjuEC5SqxGog/+TCv+AFkTlb0SVSEcCQQBfCZpINdXJ3oqBCLqNeht/jQQUSf
         1jTCqIwoAGsw2l0ydyeLFBrOvZtjH76wWcWUx+NVgY38tzucinN88c54nEsRDIqZIekV
         QLTKok3KZu6+27PjODKZEbxYVVFv3WR0+bmIQNwVU7fVNwXkMavB80GJ3iHJp8FVG1gN
         OAG7HlUEKU5MotixRie+8SsHh6FeiT4x6MdittvEIGHQrGPPtRmJI85SjYGppzRhrLMn
         v4/w==
X-Gm-Message-State: AAQBX9c7iQ+rCBuVt98lqdcWPgs1TveZRsnDS647yOKnQkWznlpOTabG
        iitSDjJUC4kKcFgiPtDgetPoODoL9ht+h7sLKCg=
X-Google-Smtp-Source: AKy350YMixvABD1v5xTPm0W/P2e7tubHnHyRyprwJ5WStSfxHTEc3rUAOA8vPbPzd9mbrwAz0AzASR+eahOAusKqDIM=
X-Received: by 2002:a50:d6d6:0:b0:4fb:c8e3:1adb with SMTP id
 l22-20020a50d6d6000000b004fbc8e31adbmr5466626edj.3.1679917330456; Mon, 27 Mar
 2023 04:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230327081828.1087364-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230327081828.1087364-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 13:41:56 +0200
Message-ID: <CAJZ5v0h9RNMOQXQiquSj5qA_4m8sNHTHvjJR+OHkHg51AwSMRw@mail.gmail.com>
Subject: Re: [PATCH] driver core: class: fix documentation for class_create()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:18 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> In commit dcfbb67e48a2 ("driver core: class: use lock_class_key already
> present in struct subsys_private") we removed the key parameter to the
> function class_create() but forgot to remove it from the kerneldoc,
> which causes a build warning.  Fix that up by removing the key parameter
> from the documentation as it is now gone.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/class.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index dbaeb79ae917..0f8938a17144 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -223,7 +223,6 @@ static void class_create_release(struct class *cls)
>  /**
>   * class_create - create a struct class structure
>   * @name: pointer to a string for the name of this class.
> - * @key: the lock_class_key for this class; used by mutex lock debugging
>   *
>   * This is used to create a struct class pointer that can then be used
>   * in calls to device_create().
> --
> 2.40.0
>
