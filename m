Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97760D2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiJYSBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJYSBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:01:43 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B7B857;
        Tue, 25 Oct 2022 11:01:35 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13ae8117023so16612546fac.9;
        Tue, 25 Oct 2022 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xPem4Ny3wYvIh1sjQsqDWumKjWAcGbJWfmSntY9XtQ=;
        b=CWALqpt7hDvolxRZ2CWjmSM8ttsaQExuvagWy5iCU4YvcSKwzvD6dQYmDexi2ONF6D
         BFf63Mk70wjIIwId+xVgrZFZLizQngsfx1eOsFAHzoykCwUTcDjwtWneReGNYvRvSbmQ
         X0SqfU/XHsR/Ib3e7R3X16VtRtz+KHNbJKj+/XB/ZhGrfbiftKuEQBiF+/H6NU9aKH6G
         AXkUxgr8VV7qFUexxP2+nu2tAaWEVoLom1yS9j4J11EFnpqXYLFCfFG1WMtMlRQRIZKV
         se5GUOc2m6vmi9ovaeEimk3IMHPBCgftQWgrLVlNx+G3u80iI8f1AY2sdOOn7080DAKp
         mYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xPem4Ny3wYvIh1sjQsqDWumKjWAcGbJWfmSntY9XtQ=;
        b=fYt0X6vkHoAofdyEcNPrG6f5fNjC8s3+VwqEMyaJDOLV7Yi7tp25bbwRJPcJ++zImE
         lRqgcXTlJ1ixJaVgbBc21EoV7ydCyjnMU2hxuboEigg6Q7u231tzfKPRPzKD58ysj/9X
         l2aWRPmIpMjg0aGAmhfqKckfnx8+uXPR3I7cGdVrCxYetdA+dMBi2zv/2zfrp2iIQ0jC
         u7Hh4fOaM7AnHft+crb0cIjBZlUJVfGoYXLpNd9qLoJ2nfXruRqfjkmjFGA7qqsnpJ5d
         aPtcSa6Qk2U8NPEctwtBz19F2o4/+jaKaPC69MYMn+abcIElhjIcOpiXERKZU2eTmo1+
         wKAg==
X-Gm-Message-State: ACrzQf1y7JFcbixaT8p8ni4fbeuxmdVNVI1MDO3KCHvspK5DB18slfHR
        WWdLVgsqRxarRaz+MXrexuP+/+oGVU0=
X-Google-Smtp-Source: AMsMyM7OqSewQHh8e0yVXGSHVVzJa8CZOICYMpS20F7NLZgUlt9bqM9TC4uiNzazgWDzaUhUH+AyPg==
X-Received: by 2002:a05:6870:2215:b0:13b:c404:75f5 with SMTP id i21-20020a056870221500b0013bc40475f5mr6157111oaf.193.1666720895080;
        Tue, 25 Oct 2022 11:01:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u21-20020a056870f29500b00132741e966asm1846417oap.51.2022.10.25.11.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:01:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Oct 2022 11:01:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 0/3] Add devicetree support for max6639
Message-ID: <20221025180130.GA1229379@roeck-us.net>
References: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
 <CABqG17gYexJkzLou1HVP7n4CGyXq70oq68E+nCOwvf=OMFhqTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqG17gYexJkzLou1HVP7n4CGyXq70oq68E+nCOwvf=OMFhqTA@mail.gmail.com>
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

On Sun, Oct 23, 2022 at 11:23:42AM +0530, Naresh Solanki wrote:
> In this latest patch series V4 , I've addressed the comments of V3.
> Since this is merely an upgrade of driver from platform driver to dt
> support, can we get this in.
> 

This is not correct. You did not address many of my comments.

Guenter
