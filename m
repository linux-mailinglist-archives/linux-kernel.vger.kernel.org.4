Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2909F65BC3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjACIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbjACIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:30:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E60BDF72
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:30:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso19369351wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxkhIR3WdUegYdjFr6N7zZV8KkU8dbXUnACWEfDXHjA=;
        b=U0O7Kcy3PsM1cJ4UtH003YPKItoLheviE/jyVGq0yMFPsjmCyJLCQObE1X0AKIVDEQ
         GQcpsDATHU9RK53so6RFr7TQAnykUobhEvxc6eUT/GURAk9b8qC9DBWsfSTwpXZvJfCu
         OtybD+KuJ5jecW4jaic4PQj2td/CSyxBScXmICI2T5Y51kM2cS/gqSeePGc7uPXVcqro
         ercmNRbFB3EoY+vvan4/h1TEGKzXsFirX+001fb+m3aQ+TeIPcFnyA/r5+ffi65Z6n9z
         MvoqMfezgs9eZXtOEzDqUbh28WSzkXMVVNhnV2za4dNJT4ynA1Uuj1gUzMg2eCO5NW5A
         o0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxkhIR3WdUegYdjFr6N7zZV8KkU8dbXUnACWEfDXHjA=;
        b=cXWgPLBZiE1Dvy30nphDl7R8YME9rMG4BAml9TkY53Xsjk8Q+ntth0sXFKMkIc9oXm
         mxADrfO4fRCxcv0IjEf7CFvfjxEHC4oBaO6ZsJdlrYi9kfGGRCtWSZp1ABOJNuNWYPGm
         krvtdKbTbFkSV7es0nx0LXWJcmaRG21WsJpWoS+R0qoaNvekmp07m2XRogJNB7CNbFr9
         IGF1BrKAJU2nd0kkyvfE/6HWmY0gUMmRn4W6DkTCd1Z8f847kRPc1L77R0TWhKHQ0f0v
         NLvIvuXSV/jsx1N99/k/hqOSY+F3qxwzEo/eX18+vqm0u1AgU9Z/mGglwg1KDESEuRoo
         YKtw==
X-Gm-Message-State: AFqh2kqJyM4QfHU90klbEtWCJAhVnyrm4GqjjST5TsTOFMOeSysJ775N
        ujc6HqD04Wd3EXklStjJq6s=
X-Google-Smtp-Source: AMrXdXsSKAQzDPooeHFHc9wCul2eM0IwEHdIsD8jnrUulL2L8h/jXoDmUJ8kfNBXnYvDd76ra/mKpg==
X-Received: by 2002:a05:600c:1d89:b0:3d3:5cd6:781 with SMTP id p9-20020a05600c1d8900b003d35cd60781mr29942129wms.37.1672734608066;
        Tue, 03 Jan 2023 00:30:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm41943812wmq.44.2023.01.03.00.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:30:07 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:30:03 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] staging: rtl8192e: Rename TSSI_13dBm, Pwr_Track and
 NumTotalRFPath
Message-ID: <Y7Pni7tvFPhcz7bu@kadam>
References: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
 <c7d3be41602e656170de46ea649b5bdf1081d5cf.1672330343.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d3be41602e656170de46ea649b5bdf1081d5cf.1672330343.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 05:25:46PM +0100, Philipp Hortmann wrote:
> Rename variable TSSI_13dBm to tssi_13dbm

I would probably have kept this one as-is.  It's not CamelCase, it's the
correct way to capitalize it.

regards,
dan carpenter

