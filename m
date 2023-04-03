Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C131E6D4FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDCRzJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjDCRzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:55:07 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1104830FD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:54:40 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id h8so120666517ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+fyidJQ4GqC1wOb6mI/36cBcytiHJMsVDvwxUw/5fM=;
        b=NT3ZwC+6r4hvz7cmNYnr92qC2Rpb+fmA16s3k4WuGGdnkiPcBX6SSwyRuTCU4b2VPY
         fJM8kk81ZNVStncDuxX2UZyu4A1P++pzGpTbLkkI/jic2QG0iLjxLHrW4vVH6BVJkCFW
         qZpG3Iv9PKxI+tVZrufa5MSr6BKQqIPFhTEcXXmC5UOaDJScF7IcM75/e8m4lw8XCz9i
         vlHD2POwn3Z/Ehe+3RqjmnGDENGBvFLp+uLQGuu/MNw5fOz8mPbIeefQ8YvFbr5IBtpF
         VdKTFN0hbxx+pZ+GD7lm75WEpJ+68vTaAtjxrXeyBGOhgTqq7Uu//1GJsfKg/OoEgham
         wFQg==
X-Gm-Message-State: AAQBX9f0C8tECfncWJ8XlCGN8bD8dUazFpsEvEAhs4MFdWW4Cau0Dd4W
        965LBMdV291s/geCdFJsf04Ob25G6ql9flBJOaA=
X-Google-Smtp-Source: AKy350ZXad9ywbhCpCtRT85XHdQA+9Wt/HdKOmePpcDEFZFa3ZqFeoWUelpGwzugEL/4wE0ioyk2yONwjlUUzR96ecc=
X-Received: by 2002:a17:906:37c8:b0:934:b5d6:14d0 with SMTP id
 o8-20020a17090637c800b00934b5d614d0mr19507374ejc.2.1680544476919; Mon, 03 Apr
 2023 10:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <2023040218-scouts-unplowed-24d2@gregkh>
In-Reply-To: <2023040218-scouts-unplowed-24d2@gregkh>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 19:54:25 +0200
Message-ID: <CAJZ5v0iWdnh+OZqDsVjORfxa1mcqS_YUfQXoEFgL=UCLFL0UGg@mail.gmail.com>
Subject: Re: [PATCH] driver core: remove incorrect comment for device_create*
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Sun, Apr 2, 2023 at 11:11 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The device_create() and device_create_with_groups() function comments
> incorrectly state that they only work with a struct class that was
> created using class_create(), but that is not true now and I am not sure
> if it ever was.  So just remove the comment as it's not needed now.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3ee5d206e7eb..7a42d1b6b721 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4330,9 +4330,6 @@ device_create_groups_vargs(const struct class *class, struct device *parent,
>   * pointer.
>   *
>   * Returns &struct device pointer on success, or ERR_PTR() on error.
> - *
> - * Note: the struct class passed to this function must have previously
> - * been created with a call to class_create().
>   */
>  struct device *device_create(const struct class *class, struct device *parent,
>                              dev_t devt, void *drvdata, const char *fmt, ...)
> @@ -4371,9 +4368,6 @@ EXPORT_SYMBOL_GPL(device_create);
>   * pointer.
>   *
>   * Returns &struct device pointer on success, or ERR_PTR() on error.
> - *
> - * Note: the struct class passed to this function must have previously
> - * been created with a call to class_create().
>   */
>  struct device *device_create_with_groups(const struct class *class,
>                                          struct device *parent, dev_t devt,
> --
> 2.40.0
>
