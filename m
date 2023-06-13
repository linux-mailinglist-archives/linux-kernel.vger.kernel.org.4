Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5147672E7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbjFMQDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbjFMQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:03:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C8172A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:03:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-652426346bbso4462346b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686672182; x=1689264182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XLKszotKhSA/rGUpooZvUbvL208sk6gDseyGx75RSQ=;
        b=AU2ZvdW5MCdki0WhUEZIfD8v67l4++mblsbArrRmhPYFf93ip5Xo07etXatE/A2JsO
         f7uRySSMgsUIdi1Dk0oFWdBlXzyk3lFx82I5oG8bsds1gABbpRh3F4rvYeBDv17ab+ll
         w2gvsKJo1pl8jc45OnxlMZYCqkmmexTWVFLQ0qLJ/f0TzXtv64C799pNu+GHYj92JxrJ
         hGmxzpr9ZJ1KwXuiDoFxY+0PNVYETdf7maft6hzRbnGE0gB2Z0Ie4r9G+jX1G+ppSQRz
         hlcj7AuIYbY/VRJXh03+CmEYBW7zvsGsjR4f0KfyIaF4XHcyBbSj2DqteIZJAGcCmQgO
         ucrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686672182; x=1689264182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XLKszotKhSA/rGUpooZvUbvL208sk6gDseyGx75RSQ=;
        b=hOY5Rh7ELAjPMx71l0UhhcHhs/8N2Ln7Ekm+Wne6E29cVXgvTnZj9CKZKx/cFZ1kMq
         GB8P1VyASbNOZszpyB3pTwYINOKUnuAk0Blyj+8hQpwaK2Lo/anyDOk0yk+9VHmmEvzJ
         oEw1p/upgzxsloA6UIa0CEoh0aLUEP3p5gfDre92lF8sNQXseaRah4wJSm96+hUKbamJ
         tyIyjU9fpwugJazZA6NGpao3JKXsRcfTj6suk5NklU04Rvmma4pdqC9JhhJckbevPZeq
         EVyzCQs7paAY03K2EQBO4uSiYU8aT+222qXjcuc8XOnmgzHPIuknXT7rHA6E8dTO6n99
         P68A==
X-Gm-Message-State: AC+VfDz9DDffcyTUcmVTZq4EEC96B5dib7A2HDqLOUYD27B9WxtFgYSP
        ioxGb9b2086/QD/jvGS5hio=
X-Google-Smtp-Source: ACHHUZ5jmNkJowRgxGcz/UiH3yP5ER0/3Z4DFPBPshkOjkmBIDZNUXN47bjCLgkI/TVMb5IbFYL6Ww==
X-Received: by 2002:a05:6a00:18a5:b0:662:2b1c:be80 with SMTP id x37-20020a056a0018a500b006622b1cbe80mr16416266pfh.28.1686672182463;
        Tue, 13 Jun 2023 09:03:02 -0700 (PDT)
Received: from redkillpc ([49.207.203.99])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0064378c52398sm1197237pfo.25.2023.06.13.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:03:01 -0700 (PDT)
Date:   Tue, 13 Jun 2023 21:32:55 +0530
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v4 1/3] axis-fifo: fix smatch warning for format specifier
Message-ID: <ZIiTL5bzMUgs3L5K@redkillpc>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
 <2023052814-savage-culprit-2096@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052814-savage-culprit-2096@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 09:59:27AM +0100, Greg Kroah-Hartman wrote:
> So please just remove this entirely.  Also, attempting to print memory
> addresses to the kernel log is very suspect and generally frowned apon,
> which is another reason this shouldn't be done.
Agreed, will be removed in v5.

Prathu
