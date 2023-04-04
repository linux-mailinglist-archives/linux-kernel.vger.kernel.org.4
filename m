Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF236D6DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjDDURe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDDURc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:17:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4288F30DC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:17:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c9so33434050lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680639449;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abqU6e5mGN5Ie3yHaJjnghY9uWXlBeDrSsd4ZXtSlcE=;
        b=AthrX2uqoEbkZRPn0FHe3ifq1K3U2i3S9zcMY+tu3kGZoWd6idRsIOfPni0juwMrkz
         4Tdk72WfCr9hNb4lbHgcp6p32Dq5ewsT9dUduhPT0Amx9nYmr2JocAAN72KhFuka0SkB
         URnphLICMTDDNtX7rQj6COxT1DDWLzFUaVf5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639449;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abqU6e5mGN5Ie3yHaJjnghY9uWXlBeDrSsd4ZXtSlcE=;
        b=XMMeTXFQZPa3gYI/VweYnnJaymX49aPVp72QlWwdd8PHxqleQ4NAE64XGTxCH48Z1I
         zvkH7ffX4iJzj7X3s3DbDN9r6Lu8bEmruVZfYef2POn90qXxf+isxnMX7p+UrFrICW3L
         IGhpa+7Oz967/9rp9fyI5uqkKM2NYL6z+7kRMBhBZ6/pRgw7EOYShQkDZEI7Rv7LdmWd
         pJFXtkdbCLXQlTCBWIgOh8T4ix2jzTaxCDvDNp67PKZnqkxwFX12mQJRY4ECZBg5Zq3x
         oWk/1fPoG0PjIg+TwWrSbcsxiQPJTKNNReDaapFTrXj2KabmICaqsJDwl1SgWDdv27Or
         tmyw==
X-Gm-Message-State: AAQBX9eiQVIl1AygNsDrPf7xNVgX3sz2BIb6xAY0SIvmBG4AVpc74qoj
        vc9y8n3Mvt+Qlss0JDcapkWIZThavfEeeQsC6o5y2A==
X-Google-Smtp-Source: AKy350Z2t0iCf4BD9mrWgwCx4PqG158KKpK5Qjve4ELYyWCr4u1y7Wb6nCFChRtv+qgMQH9/0qs/NSe7v7L99tC/w+c=
X-Received: by 2002:ac2:5d64:0:b0:4e9:c3db:f383 with SMTP id
 h4-20020ac25d64000000b004e9c3dbf383mr1101028lft.4.1680639449488; Tue, 04 Apr
 2023 13:17:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Apr 2023 13:17:29 -0700
MIME-Version: 1.0
In-Reply-To: <20230330141051.1.If8eb4f30cb53a00a5bef1b7d3cc645c3536615ec@changeid>
References: <20230330141051.1.If8eb4f30cb53a00a5bef1b7d3cc645c3536615ec@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 4 Apr 2023 13:17:29 -0700
Message-ID: <CAE-0n51Nn79ZjJv_gG+00PdQ03J-vbYgxQiZmWCy6RNGxQqtFw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: qcom: Add reviewer for Qualcomm Chromebooks
To:     Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-03-30 14:11:00)
> Developers on the ChromeOS team generally want to be notified to
> review changes that affect Chromebook device tree files. While we
> could individually add developers, the set of developers and the time
> each one has available to review patches will change over time. Let's
> try adding a group list as a reviewer and see if that's an effective
> way to manage things.
>
> A few notes:
> * Though this email address is actually backed by a mailing list, I'm
>   adding it as "R"eviewer and not "L"ist since it's not a publicly
>   readable mailing list and it's intended just to have a few people on
>   it. This also hopefully conveys a little more responisbility for the
>   people that are part of this group.
> * I've added all sc7180 and sc7280 files here. At the moment I'm not
>   aware of any non-Chromebooks being supported that use these
>   chips. If later something shows up then we can try to narrow down.
> * I've added "sdm845-cheza" to this list but not the rest of
>   "sdm845". Cheza never shipped but some developers still find the old
>   developer boards useful and thus it continues to get minimal
>   maintenance. Most sdm845 device tree work, however, seems to be for
>   non-Chromebooks.
>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
