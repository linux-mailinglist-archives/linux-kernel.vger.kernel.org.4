Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3468034F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjA3AjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3AjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:39:17 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD51CF41;
        Sun, 29 Jan 2023 16:39:16 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1442977d77dso13255205fac.6;
        Sun, 29 Jan 2023 16:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQdDfBq+vMF/O7FM4LZuZL7r34CL6O59Wnl755Km6vU=;
        b=l8ipMy4pGRnmFzWMy34EV5s6qCA0dnFvcV1WLPYwuDAQ+YddGB2zNSOgkvAXkoB7oO
         9d2foK6XKFbc6GuRwa/zyw0na72IN6jphiv+6326y4Xqz8O+zqcKc2GQfaZIEwoXbySs
         /7jIwYIcxFSAZ1SfEYlJid5m8TgqZebvd5EL+rBP1EMmqmpm11wYF9vMyPnf83WJ6hgt
         MT2lBXCjNyTjer5or8HnMWmHhu1m/8WaezQNUzciD4MPwZPEtZruOWIroEXso48NAN3/
         xmr/eBGIT51nD4iKCctsTk6+gzOOtfACyWv0GVQ0rFcuFJ9cYptmEGT/UfOwWQMDVarV
         cL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQdDfBq+vMF/O7FM4LZuZL7r34CL6O59Wnl755Km6vU=;
        b=0raitiX0cxhaERlnzuQ/ZSQBskdM/vR6qhE869tIaT9f2UuRxoaONWmoF4iM7lYiW/
         Mf4qwU/ktKGS+zmyk0U0oueBD5PnZvI3or3/f+OjP69aZq4Ra35GOy5z49JpStu6kKNM
         HmRs4xSOrRsRimmrp9dPTEHR/87Lbnq1VzRjasyDpvcce7HLj1ahRze3gDQqJmLXJHWU
         QGUSrljfPvrFPb0xre09wuBBaV24uxxrwZwnndgXU/ieflSxagJtXE7GeFoQhRa2y8gc
         a9gP6NWWmXbawg/KY7nmBbnSCGOKqX2iKsxv3aA47+noP4O5EZCjlzK6q2LXMrjIUFno
         tSzg==
X-Gm-Message-State: AO0yUKWPTq2tw8SJw5K4i9ejX4uj0VOr8RGVVuAXfIkuGcFzETjwXF4B
        Svxg/BAmwo7v+tSJ3fud62w=
X-Google-Smtp-Source: AK7set8m5admbPwz4sasitoVVR4miMIKzg4X7vK3ORG1mDwTWn0RYkMMpJR4KaFUvGXHSI58z1ReRw==
X-Received: by 2002:a05:6870:7014:b0:15b:b523:3299 with SMTP id u20-20020a056870701400b0015bb5233299mr3432682oae.28.1675039155910;
        Sun, 29 Jan 2023 16:39:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8-20020a056870e38800b00144e18d8525sm4608589oad.25.2023.01.29.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 16:39:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Jan 2023 16:39:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/9] Documentation: hwmon: correct spelling
Message-ID: <20230130003913.GA384090@roeck-us.net>
References: <20230129231053.20863-1-rdunlap@infradead.org>
 <20230129231053.20863-4-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129231053.20863-4-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 03:10:47PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/hwmon/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org

Applied to hwmon-next.

Thanks,
Guenter
