Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA56BAD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjCOKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjCOKQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:16:22 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D41BFD;
        Wed, 15 Mar 2023 03:15:41 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Pc5r70C0zzyWK;
        Wed, 15 Mar 2023 12:15:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678875335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBLC5PGoB3NkXvs+oeGK9GvnZ0dZH4DahY5N86jeNes=;
        b=NjBBXfPRIwxvMLLnlq6rtXiqHtBZc7I5mDV3+A+l1o/XZGQ5TY1wHVwANtr3UxDpldTEMf
        YObOW63ffwHNG6X57NWWD3+hJiTcbbT2w3EYd86ZXFtM+hix4DZzVIWzU6SLy/BeJu9eo7
        WNFwmYahxqHeVyH0z6za1ICO9l82CVc=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678875335; a=rsa-sha256; cv=none;
        b=XEp2UaTpFnkeI4b1W3BkA5ngOZjA3BATeOfR+SsguANctnSUaQQ7KOjm9Gd7k+YG0qFcBF
        qLioTDwYqlPLMowGaUZZXxI3efuClhi8NpYJxrmWpxYAV7CAX841PGKPTpLAd0OiM6BuAr
        ODZVb9uvAhYXbFD7SE5cr3J4z1HW8/Y=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678875335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBLC5PGoB3NkXvs+oeGK9GvnZ0dZH4DahY5N86jeNes=;
        b=KCIG01c25rIFjsS9Hd7sNaYKzO88CuITKbAB4gkawAptvFWt7Q/Ag0Ji5sdObBUqS3OK0e
        TYkneD2uu0Ba3tejhxwcA96DJm2kPs2NpaHCIMA5TimqOpaQVD2ecPxXPJnl+DUkraO/LV
        59k0v0lLiSnM7i0ii6BRFWeyn6eBrVo=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id A4E1A634C92;
        Wed, 15 Mar 2023 12:14:28 +0200 (EET)
Date:   Wed, 15 Mar 2023 12:14:28 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv3 1/2 RESEND] doc/media api: Try to make enum usage
 clearer
Message-ID: <ZBGahMbA1fBrKLYP@valkosipuli.retiisi.eu>
References: <20230219120034.5819b4ac.dorota.czaplejewicz@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219120034.5819b4ac.dorota.czaplejewicz@puri.sm>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

On Sun, Feb 19, 2023 at 12:00:34PM +0100, Dorota Czaplejewicz wrote:
> This clarifies which side of the calls is responsible for doing what to which parts of the struct.
> This also explicitly states that repeating values are disallowed.
> It also expands the terse description of the access algorithm into more prose-like, active voice description, which trades conciseness for ease of comprehension.

The commit message lines should be wrapped at 74 characters. Please do use
checkpatch.pl in the future. There is also no apparent reason to add a
newline after a period.

The same applies to the other patch as well.

I've addressed the issues this time.

> 
> Added: mbus codes must not repeat
> Added: no holes in the enumeration
> Added: enumerations per what?
> Added: who fills in what in calls
> Changed: "zero" -> "0"
> Changed: "given" -> "specified"
> 
> Still unclear how it works so didn't describe: "which". What is a "try format" vs "active format"?
> 
> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> ---
> Hi,
> 
> I took those patches out of the freezer. I made sure they still apply (they do), and corrected some errors pointed out by Jacopo in the previous round of reviews.

Ditto.

> 
> Thanks,
> Dorota
> 
>  .../v4l/vidioc-subdev-enum-mbus-code.rst      | 38 +++++++++++++------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> index 417f1a19bcc4..63bff24d0520 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> @@ -31,15 +31,28 @@ Arguments
>  Description
>  ===========
>  
> -To enumerate media bus formats available at a given sub-device pad
> -applications initialize the ``pad``, ``which`` and ``index`` fields of
> -struct
> -:c:type:`v4l2_subdev_mbus_code_enum` and
> -call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this
> -structure. Drivers fill the rest of the structure or return an ``EINVAL``
> -error code if either the ``pad`` or ``index`` are invalid. All media bus
> -formats are enumerable by beginning at index zero and incrementing by
> -one until ``EINVAL`` is returned.
> +This call is used by the application to access the enumeration
> +of media bus formats for the selected pad.
> +
> +The enumerations are defined by the driver, and indexed using the ``index`` field
> +of struct :c:type:`v4l2_subdev_mbus_code_enum`.
> +Each enumeration starts with the ``index`` of 0, and
> +the lowest invalid index marks the end of enumeration.
> +
> +Therefore, to enumerate media bus formats available at a given sub-device pad,
> +initialize the ``pad``, and ``which`` fields to desired values,
> +and set ``index`` to 0.
> +Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
> +with a pointer to this structure.
> +
> +A successful call will return with the ``code`` field filled in
> +with a mbus code value.
> +Repeat with increasing ``index`` until ``EINVAL`` is received.
> +``EINVAL`` means that either ``pad`` is invalid,
> +or that there are no more codes available at this pad.
> +
> +The driver must not return the same value of ``code`` for different indices
> +at the same pad.
>  
>  Available media bus formats may depend on the current 'try' formats at
>  other pads of the sub-device, as well as on the current active links.
> @@ -57,14 +70,15 @@ information about the try formats.
>  
>      * - __u32
>        - ``pad``
> -      - Pad number as reported by the media controller API.
> +      - Pad number as reported by the media controller API. Filled in by the application.

Here, too...

>      * - __u32
>        - ``index``
> -      - Number of the format in the enumeration, set by the application.
> +      - Index of the mbus code in the enumeration belonging to the given pad.
> +    Filled in by the application.

Wrong indentation.

>      * - __u32
>        - ``code``
>        - The media bus format code, as defined in
> -	:ref:`v4l2-mbus-format`.
> +	:ref:`v4l2-mbus-format`. Filled in by the driver.
>      * - __u32
>        - ``which``
>        - Media bus format codes to be enumerated, from enum

-- 
Regards,

Sakari Ailus
