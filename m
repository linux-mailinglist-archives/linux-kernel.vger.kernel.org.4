Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B67766E09C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjAQO2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjAQO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:27:55 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835E65AD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:26:43 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 203so34180197yby.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j6SAxozLv1BaiKA41UPeSRieBpaAk5WSqvAlUBxsAgk=;
        b=j+EUd9Ba88tssQnyy1SfACH1y9O7e9AMTIGPLO75lSwgETMpxs0nwwbjQzVYOe4inZ
         X4uqbwBSNkqcD+qBz2YkJlkt0SdwTmcmP3ttM8HLSxbq8uuEcVZxIm270IbRsDbg2C5P
         QSkRYMMDeHx8xe6ynrQXPng76uqPz8afAsIYJXwPlnpITRReI4HJsCI874bu4ptewwbE
         pjQevO6CkNFMo6Miewupuu3ncZ4rzRDYIL+1cweYz/XFn3uFr5G3qldFEfBmbBQOSyu5
         oAU6q2ZSq0etst3DXluFPiDeoCuabeY/66+yeFQO209lz97EkSeTg5sc9PGrr0x2HWVW
         e55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6SAxozLv1BaiKA41UPeSRieBpaAk5WSqvAlUBxsAgk=;
        b=vz5iQHnCYWqS+x5RxlVC0lQHQO0+t+LGMAiX2vyddycP0X7B+34zvQHg6nklsRwFWW
         /fjgQtjmK6nto6U2AL5dudKvDLb+HfiytIRg6uK7pAb3wE4Bw1RYPzKwdd/pjyPhAGEP
         6xgNZEbno4BS6kKs7Dvwi+OsLre5FjKsxGK91BKBXebGDrdjXK90480eTW7LjlMszNzV
         ZzjDfVsnlUT91Ors3hKJzavOP4Z+WUlad1h/KA1qA1600SQsTmTvhbkzdgEzjyXxdwNX
         Y+1UZRmntXrqK5IB210PK+QsCHzML8jGffmNEM6jlQlHhZGntsCkvAYlRsPO3xPPer4I
         P/Og==
X-Gm-Message-State: AFqh2kp7bLQ10I2EL0sGstm4Vy5ZrbaucBHPxyyCRR7CarrxJsB3fjok
        SucHujTYEOOZPJBYDlYWUi53v4ahfaKfrfJYFID8xg==
X-Google-Smtp-Source: AMrXdXvAhed3tfAIybpkj17yY1n9A8EyPgwlmUDjhWkluk7/N6DS2W31nR70QAL+sLUeM4X/0JoD7gUmvXTfz4mZUN0=
X-Received: by 2002:a25:c092:0:b0:7d2:8687:aea5 with SMTP id
 c140-20020a25c092000000b007d28687aea5mr504980ybf.210.1673965602704; Tue, 17
 Jan 2023 06:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com> <Y8avtfifZpy89rS3@smile.fi.intel.com>
In-Reply-To: <Y8avtfifZpy89rS3@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Jan 2023 15:26:31 +0100
Message-ID: <CACRpkdYTFDsU7xhu812Lh1mA1Hs9kGeid+akR84ervAsaxVYkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Proofreading and updating the
 documentation accordingly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 3:24 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Actually I have missed the repetition of the comment I put in v1,
> i.e.  that this would be good to be attached to my PR where the
> struct pinfunction et al. have been introduced. Can I have your
> Ack?

Sure go ahead, I can also take out the patches if you rather
include them with a  pull request.

Yours,
Linus Walleij
