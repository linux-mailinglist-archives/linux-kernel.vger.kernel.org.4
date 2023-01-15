Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2896066B269
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjAOQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjAOQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:05:42 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83CA1B56A;
        Sun, 15 Jan 2023 08:03:20 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1442977d77dso27022889fac.6;
        Sun, 15 Jan 2023 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29RIxf9KEO9r2osuQUOKuB87LvQP24yzq+yQeBGdEUg=;
        b=h8jDDQktLDMxClHxKfBjQY1enZGMxo/1zVr3XfBgkPqwzcIBAZBAZzRqZhIcsxx6JY
         7qrpWuTSjkr9cDo01Grhtw0s8wziTA2E65Zsp7FNnTxflsEJ5dU4UihbEhoSQGARqOha
         BU58exlqKl6WrG1Kj03nSrlELJRoyYd3nB+0aQjHq1lDliuBP0bg2U5NqBVj6o5Dheat
         n0adVAJlcPGk/1nbEII6s7OZ/HYkfAGMYfEAwRslLIAXL4ZDx1/fLFlanaZg9EwHTLGt
         qTn/l1LGnv4CLNXYNL3dV/4VBS+00V7GU8tBtiSkLtWVDAh90mQsVJHn1bky3C50WV+r
         zJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29RIxf9KEO9r2osuQUOKuB87LvQP24yzq+yQeBGdEUg=;
        b=v3AV19u79lXoBn1XlBAYE9vtepM+oC3L5X1lpn/+QLkdwSRMBnzCoRueUtGCstNobI
         6dnN5VUOM7GgA0b+FXNRyaXy4nZhbdEI+Ne3X0L7vinvakMHLHMf4HcgMER6m7W8QxDU
         C4yCO15Znf9D6ulf4QS39gLdg9d93vKapTYjG+SgqjQf49/iNqGvRYM7nnUm32l65Fiu
         A8o7sye5WHdDkHZS0A7jzKl2axgm9Vrk3nzyfvs5b4CPOz5YT36Yv24RkukKRhDv/rKU
         S+bcngS201jPuqURkqwly4VBedrow2nHVzii2d4BP/b9u0SYmLQZ8FidqeU5O5XwIsoM
         bEHw==
X-Gm-Message-State: AFqh2kqvk+pxSs/F15a/xiyk1mMtI+8x/ligVBdh8pq7vVoQ2XlUaTeP
        GRuYIIxI0irjZk2K7jFx4Ik=
X-Google-Smtp-Source: AMrXdXsF6yy+6UAqZ4h+U7ZWOPBQnVWMvqC6nO67Mw9ST4bXR8dDzViiXhU7+78o5y6Rj7tQtRU4iQ==
X-Received: by 2002:a05:6870:b40f:b0:15f:32b:6e46 with SMTP id x15-20020a056870b40f00b0015f032b6e46mr3739944oap.49.1673798598028;
        Sun, 15 Jan 2023 08:03:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870218300b00152c52608dbsm13495137oae.34.2023.01.15.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:03:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Jan 2023 08:03:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (sht15,sht21) fix kernel-doc warnings
Message-ID: <20230115160316.GA1245778@roeck-us.net>
References: <20230113064556.21685-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113064556.21685-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:45:56PM -0800, Randy Dunlap wrote:
> Use the correct function names in kernel-doc comments to prevent these
> warnings:
> 
> drivers/hwmon/sht15.c:682: warning: expecting prototype for sht15_show_status(). Prototype was for sht15_status_show() instead
> drivers/hwmon/sht15.c:705: warning: expecting prototype for sht15_store_heater(). Prototype was for sht15_status_store() instead
> drivers/hwmon/sht15.c:738: warning: expecting prototype for sht15_show_temp(). Prototype was for sht15_temp_show() instead
> drivers/hwmon/sht15.c:760: warning: expecting prototype for sht15_show_humidity(). Prototype was for sht15_humidity_show() instead
> drivers/hwmon/sht21.c:128: warning: expecting prototype for sht21_show_temperature(). Prototype was for sht21_temperature_show() instead
> drivers/hwmon/sht21.c:149: warning: expecting prototype for sht21_show_humidity(). Prototype was for sht21_humidity_show() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org

Applied to hwmon-next.

Thanks,
Guenter
