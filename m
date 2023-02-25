Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8636A2A60
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBYPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:03:17 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4EDEC67;
        Sat, 25 Feb 2023 07:03:11 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q15so1802266oiw.11;
        Sat, 25 Feb 2023 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zu2lUBG6uCOUfoVwtW3l7nzRZxOie8bGR6gq66upT0s=;
        b=n5PwIIMRUtj1yHMbwgWaos2ycuK+TzY9m3Q1r0EUeiAPJ+uRMUkUqkEZFg4f/YkzCY
         krPvvJ3EVkToPs7xi3XcisQZ1gf8/PYO2GWDpMqSQYNuwAESffRCxs/LV6WMf1F4VAnl
         QW3HbNSmWMRSOT7Wv2yf/+GGODA0GqN94Q06rO3WX7SojuWs3BOEaZcYVRdgdooLLSXh
         j/qs9pcebhXRIR36bpPrCQVaJFsKv7ZmLPFl+xqDxCnnHVEXyRjqKTG+MFM/7UaHVHKK
         iNvorzaUhBdf9XmEuUuKNMVnP/K/x2Wng8yIBEa2ddqdXHaVeF1h+BReA+/a630BDkrG
         wurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zu2lUBG6uCOUfoVwtW3l7nzRZxOie8bGR6gq66upT0s=;
        b=TCuZIYl1WXKv25x8FVAODDfUAs7Na2rc96rlBjVdS3UUzLdeX/qeMzc2NbW1VS0udK
         6+DSpSJKEYSOe+1v8qLWD26VvF0ZAhe/+6bKeOa6sI9Artn0WolhgIjMM4zu6+z/klUQ
         VbcSxNdXevq7gJ17f1xhjHtd6QgcWxAwx0jg0IaKkGq8myU+FhKG2Y/qqqG/rPvtHeqk
         Rp/q1/i5yWMt6/WMpiBviHJmmXXXhAUOw4UC5OxKpSqq68EFLg+LG6qoNpQp3cQ2PGtd
         s6Dt0deHA9uy1ysPzkzsG12Cwd9rPKcaWVB3v+bqvzUfdG0/qAHfmY0BOE6S501JC/km
         pVnA==
X-Gm-Message-State: AO0yUKU1SPG1lIz1n8E+0iqaEhJLcGKU6UL2w/IR3pACHSPfnMtuOLHe
        TDS/dFqAItZ/5i4axlfqhsM=
X-Google-Smtp-Source: AK7set/DB1kIxnVk/iRTI7to0AphJavS02EUvjPzYojUbbazDXh17J1Ij9ONVAj2K/vkd3f6W7vryQ==
X-Received: by 2002:a05:6808:90a:b0:360:febd:ed44 with SMTP id w10-20020a056808090a00b00360febded44mr8274244oih.51.1677337390586;
        Sat, 25 Feb 2023 07:03:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi28-20020a056808189c00b0037d8c938d62sm922310oib.50.2023.02.25.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:03:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Feb 2023 07:03:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (adt7475) Fix masking of hysteresis
 registers
Message-ID: <20230225150309.GA3647996@roeck-us.net>
References: <20230222005228.158661-1-tony.obrien@alliedtelesis.co.nz>
 <20230222005228.158661-3-tony.obrien@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222005228.158661-3-tony.obrien@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:52:28PM +1300, Tony O'Brien wrote:
> The wrong bits are masked in the hysteresis register; indices 0 and 2
> should zero bits [7:4] and preserve bits [3:0], and index 1 should zero
> bits [3:0] and preserve bits [7:4].
> 
> Fixes: 1c301fc5394f ("hwmon: Add a driver for the ADT7475 hardware monitoring chip")
> Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter
