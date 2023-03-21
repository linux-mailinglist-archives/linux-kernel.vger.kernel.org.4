Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE46C3D19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCUVyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCUVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:54:00 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1110A5F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:53:39 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-17683b570b8so17614744fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679435619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7dlhMHJsN/E3hZ6mSfVJ0w2onuWiTVDlzOKy1rs8gk=;
        b=770KHevIbpsKzMBVnEMR51JYMqDODixAf90QVJCuXTp/AMUUF70chB7UsYeTdr/5Lb
         Shp7pjFmEUi2xGRx8cVLsepS3+s1hYA0m+sf2kSr4IaSzTrrrDwSNpo8yYyw5dFaVntl
         ZdvkQ8d6hY/fkYOSfRmwwy771UsoLRgmb0FLJxbpxJfsNfhIGvHqEamQsVfC1YrRtULe
         /JAsKeBOHbK6gechxNoQJpQSrQeeWkYeh819VgbQVkL6lpo7syULARV196YOxNGmUFeI
         34fAiMhcFk9GjOygl4GJNmRdsaBPQ7cU9PxbrYXnM5jktjacRUTWt3V51MVX+NBHEOb+
         hHyA==
X-Gm-Message-State: AO0yUKWL3ItM9293KZ5O8JPDnWP05Kt4ehy7f2QxUkE+cFtWyCVIfw1c
        GFTr2DJb7AAgxAXrnA3ZGA==
X-Google-Smtp-Source: AK7set+lm76NDlTKvThCGXJnW8/L+gYBJXTObIByLduFQedcvor/xR7l0FIkytHpEXUMnsitoZwgGg==
X-Received: by 2002:a05:6870:8302:b0:177:c59e:39d8 with SMTP id p2-20020a056870830200b00177c59e39d8mr320299oae.17.1679435619152;
        Tue, 21 Mar 2023 14:53:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m21-20020a0568301e7500b0069b55289f07sm5742344otr.43.2023.03.21.14.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:53:38 -0700 (PDT)
Received: (nullmailer pid 1670807 invoked by uid 1000);
        Tue, 21 Mar 2023 21:53:37 -0000
Date:   Tue, 21 Mar 2023 16:53:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     krzysztof.kozlowski@linaro.org, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com
Subject: Re: [PATCH v3] checkpatch: add missing bindings license check
Message-ID: <20230321215337.GA1656483-robh@kernel.org>
References: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:33:50PM +0300, Dmitry Rokosov wrote:
> All headers from 'include/dt-bindings/' must be verified by checkpatch
> together with Documentation bindings, because all of them are part of
> the whole DT bindings system.
> 
> The requirement is dual licensed and matching pattern:
>     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/

This is not correct. The headers can and should be licensed like the dts 
files which are (unfortunately) all over the place and differ from the 
bindings.

Also, GPL-2.0-or-later is neither desired nor encouraged. 

Rob
