Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB295683516
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAaSVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAaSVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:21:46 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E737F25
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:21:45 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5063029246dso214791687b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X7pBEKn4xB6KlSsgM67ywt4YhFhtJVw3vFCQK0MunrU=;
        b=a54hMh4vQaR+SnfjHs+/tTs9WgpKM8eRewGPeGHtO7AfZ8B/IoHcC+VUKcnOuN5Or2
         g3wtl9gka5vLbNzdzK0Z8kf4V6iYujZeIMwawJr/r3r1CE+1IWzIIBDmnqRsxAwO4NLR
         P4J8TjE6RgzBp3wtbZc3nCLGKZ6aP+sOHUq9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7pBEKn4xB6KlSsgM67ywt4YhFhtJVw3vFCQK0MunrU=;
        b=iwlNgORK2WEWruPnQRMAde37eVnFrEv6QACNPynJ2MQjTDNZgjiUIlOUJ3Gl+ql5u1
         Rfr4+jfBJTbYEquLvnhHZLE0YR2hsKLsm1j/2HrRQ4Bh5KVCoI4k3Upt/3qPBZtBpFpG
         EStWbmju2woKIw7v5Zcn9zBtScR9VAFvF7vtX3tr/vTJzSkMMODxCMJy2Ylf8H5OfraF
         x/G6MD2kQcf5LuUdb5yOwndcGsIxoiTDHkiJgu8ILyoxLCjs37m8blnDWz1t5oh3EpG3
         O6kj5uQuHSuZyBszUXRud3VaEMH8qBvqqGdvVj6TeMbDQ+PLHd70gorO8BGtCm76p5hl
         M3nA==
X-Gm-Message-State: AO0yUKVs1nliWMovZlehIHUl6g2fj+zayzK2qAdifnTqm+r6vA9yvVNF
        lYrLsn38STLYSAUAHBJi7EwG6H3cVJ0WQbU4lPZCxw==
X-Google-Smtp-Source: AK7set/2RMPBY9eBahBTJEvy3rYfwwbLjgi7c1vRDs5ESG4HcYXd5DGekbUkiWg0DHXub99IRVG7DJ9cLcGN4Xa6sZ4=
X-Received: by 2002:a0d:d7cf:0:b0:50f:ba3b:8a0a with SMTP id
 z198-20020a0dd7cf000000b0050fba3b8a0amr1346075ywd.181.1675189304668; Tue, 31
 Jan 2023 10:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20230126205620.3714994-1-pmalani@chromium.org> <Y9iIzcz5AGjVXsNG@google.com>
In-Reply-To: <Y9iIzcz5AGjVXsNG@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 31 Jan 2023 10:21:33 -0800
Message-ID: <CACeCKae0s21=tj4pKvm3SyU-AUxB67oH=vO3ihHTSQ31d26ZDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec: Add VDM attention headers
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the patch, Tzung-Bi.

On Mon, Jan 30, 2023 at 7:19 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Thu, Jan 26, 2023 at 08:55:45PM +0000, Prashant Malani wrote:
> > Incorporate updates to the EC headers to support the retrieval of VDM
> > Attention messages from port partners. These headers are already present
> > in the ChromeOS EC codebase. [1]
> >
> > [1] https://source.chromium.org/chromium/chromiumos/platform/ec/+/main:include/ec_commands.h
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> With a nit:
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
>
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> > index b9c4a3964247..ec327638c6eb 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -5862,6 +5862,7 @@ enum tcpc_cc_polarity {
> >  #define PD_STATUS_EVENT_MUX_1_SET_DONE               BIT(5)
> >  #define PD_STATUS_EVENT_VDM_REQ_REPLY                BIT(6)
> >  #define PD_STATUS_EVENT_VDM_REQ_FAILED               BIT(7)
> > +#define PD_STATUS_EVENT_VDM_ATTENTION                        BIT(8)
>
> This has an extra tab if comparing with others around.
Fixed the tab and applied to chrome-platform/for-kernelci.
