Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA472E7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbjFMQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbjFMQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:03:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D193D1727
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:03:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3db8f3d94so11796215ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686672230; x=1689264230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZtfUqOfw9tmdB3aVwruyD8MVESZyU6Ak+0kZPs/oYk=;
        b=A7YhKPxZI/RLymj+CMDpilNMjQISVRB0LOnppiRj+/FdTiTe+QyK8ipKEE/LRHZNcU
         2AB5vctMtheSxOq/hCQrfb/bLpDolsPwXgCCx8m9IvDLCQpgZot+TRk5XHuJVVTjxape
         aRPvdNFcwhru7VVHrXAo7JJysBw75r3mOyNMI+1BefXarLLMllpgfQfBbocZTnAhxkO+
         H0MRpL5zhmOywQgyiItHJWe56GVupGmqvqOJgzvqFOaODLOlshBwb8BGj3mPhYmdir9x
         au3ZBsePKNP2TnN7DQ6FQh9nWkg+Lvh4EGSEDEzOXJNZvdIs8WBhLWAzIAJLUXihHM/O
         gxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686672230; x=1689264230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZtfUqOfw9tmdB3aVwruyD8MVESZyU6Ak+0kZPs/oYk=;
        b=im5Ez29fdwLKSDpaPcUOYRK20ujsQ+O+ucwPAIXxsPvL2qU+iD6NQ9E31DmnKcbxqk
         lHwM6/IipfmSKgagKIwAS8uyjve1GGz3koKNEWHisYfk7GeAH9YzfzY0uxIty+3DlUV2
         iKBmaJxXXXh+2pjvnZNQLroKqfFGHcBcs1k02+jvLjbv40gYLAg2mbehUeCwrT9GWENZ
         FVVSH10wVZBCfib34Tw1DHlYwHpKqclsicox/037/cg8G8U7wuG26GOl2ItsQRDFB/tf
         2bD10tPu75B5c51I53K3LsUUOmsLfXKIFxz1EmMwcKCkaTyB34TwSRG0gUfIeX4BH0nS
         Yvbg==
X-Gm-Message-State: AC+VfDw+cY9N78gNG6Cp8zCR5Q1TamG0HJhtgI79bDP4tebxIQUhXpUw
        LU43cVvolqiHktpRrcD1N50=
X-Google-Smtp-Source: ACHHUZ6ykPpwK4Djjme3I/llZub0siZics4kbkbL2vaGcGQV13Z7bmmmmB4FguX3G4pVAhNETSf1Vg==
X-Received: by 2002:a17:903:189:b0:1ae:4c3b:bb0b with SMTP id z9-20020a170903018900b001ae4c3bbb0bmr10833957plg.5.1686672230176;
        Tue, 13 Jun 2023 09:03:50 -0700 (PDT)
Received: from redkillpc ([49.207.203.99])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001b04c2023e3sm10422897pll.218.2023.06.13.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:03:49 -0700 (PDT)
Date:   Tue, 13 Jun 2023 21:33:42 +0530
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v4 2/3] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <ZIiTXlAg+z3h4f7U@redkillpc>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
 <20230527115101.47569-2-prathubaronia2011@gmail.com>
 <2023052847-festival-moistness-9a14@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052847-festival-moistness-9a14@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 10:00:14AM +0100, Greg Kroah-Hartman wrote:
> we should not be using a kernel address as a device name, please fix
> this up to just use a unique number instead.
Agreed, will be fixed in v5.

Prathu
