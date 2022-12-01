Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766D163F8CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiLAUKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiLAUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:10:37 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82FBEC68
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:10:33 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r19so2357417qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 12:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5BHelv3N+41uf2laSJpjxNnqMJlO6nXbKkfIvjH6bF0=;
        b=mNabcctar8gTptAWFv2qhOoG6jR3HGKA09XMyZgezk74MidRGCgacejr1mVfybneYi
         LGwixB3c7ahYtBDjCFXzcFSSb2OCsoJ68ibVHMcIHuAHvGQqkB2viOrdeVlg+RzDP31j
         6rzdkiEzi0902yFRNWpNNhTFw0rneMKbSH+6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BHelv3N+41uf2laSJpjxNnqMJlO6nXbKkfIvjH6bF0=;
        b=aLbHQUod96xHW2gXko9ALSQotW/4AVIqk+9BYC9z7AfTGLeGbo1m706+L3U+4FJwn0
         dz29hbLl1K2eXPgJuZD7gPfz3aPhoHy635Q6IQMA/IVNg5duyN/EgHcwVlGlXsPQvZJ/
         Vp7tqepsHrrju2gk3RZxO87GHtXTh2sFKUuKoK/iFi9swvlFaPBDIV/LO5/+l4kPrHrH
         a4Hm6Bv6Q9VflNkLa64e3+2Yy9eb7tjDRqtA3SlqsAWAi5zrDbs2NEb4Axfmy8vriNbM
         qou7xPR3QJ9ec51h+cqoAQayyY29mo9euUlqiXG7X9hQpCQQsptwOgyHtvth8Yo3+OkH
         gbKA==
X-Gm-Message-State: ANoB5pk8uAh0Nu0TaX+nQ5MD+qzPO70oR2sgboSfkxy8e4/aM3W5Y1Cz
        QKtNj47k3l9iyXzKgKLei7U4dtT7HKzIez9YuNduog==
X-Google-Smtp-Source: AA0mqf7zV4NhddToUDXZdGlH1vmjh2U7UTZDhpiLUQ9F8GZDw1aEDBFG0Fic3rL4G2eYwPMHv3MFh3XeZAMF/U6WpQo=
X-Received: by 2002:ac8:4a13:0:b0:3a5:b4ab:cb80 with SMTP id
 x19-20020ac84a13000000b003a5b4abcb80mr37195576qtq.59.1669925432860; Thu, 01
 Dec 2022 12:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20221130231936.1666390-1-wonchung@google.com>
In-Reply-To: <20221130231936.1666390-1-wonchung@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 1 Dec 2022 12:10:22 -0800
Message-ID: <CACeCKad16bs_f6bLthTAoEL28tPvf1S10WDeM7ugeaS9g7R25w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Create new USB driver for RGB keyboard
 in ChromeOS devices
To:     Won Chung <wonchung@google.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Won,

On Wed, Nov 30, 2022 at 3:19 PM Won Chung <wonchung@google.com> wrote:
>
> Without any driver bound to RGB keyboard, it may not be suspended
> properly, preventing USB xHCI to be suspended and causing power drain.
> Create new USB driver for RGB keyboard so that it can be suspended
> properly.

This seems like overkill. Can't you set this from USB's sysfs nodes
like power/control [1] ?

[1] https://www.kernel.org/doc/html/latest/driver-api/usb/power-management.html#the-user-interface-for-dynamic-pm


Best regards,

-Prashant
