Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B566A1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjAMSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAMSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:24:43 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F93B877
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:18:50 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d10so11133231ilc.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdoZeQNplmRhThp2c6eonI7uoiBCPYO2onFJRhJu/3Q=;
        b=Nsf8v+2rEoiKtbGI99+zqm6bmU09wTu8gl8eYKZl+OU8LT/wgDIzWNEMFfNdtsN2q7
         2e4EAg2iobCGkInNBqko0nuGAZ2CxlPidsNVcVPX87pPywi6z2PIicmW6iuzDmIPGu+f
         I7FASFi5lbSofOAjJbwaLReNbKfzrh9S02ibE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdoZeQNplmRhThp2c6eonI7uoiBCPYO2onFJRhJu/3Q=;
        b=u5AD3aJJ8R8s+Ox8P465rPYlvhRXOhEz+lcwegZNMguHHdzxfasQTWNG4OUuGVQ8GJ
         Mtrmj5xQcjp0FchJRaeUiXbZjHZcs3xHqD/Kb6KnNICcFV+FBYavtsKwjGjp48PyVkCV
         BzQxksPDBFhggg4W+ZPLSfCdsZqBG6Nmcw2rqDRMpdLnX3k0MFSu6tRM9hcEAjPCWelm
         hkiiWHilL4EC+vsMH11//LRWfN3CzDrG8nGo7GnKN3NQbPAd0VGD+fzZ3QzkVL54FFfn
         x7QxO9ldMPFqy10wqo6K6R91Lfoc4KurskgMx5gLTAMQ4MNTN2+fSjUapGAWxIC+8kg1
         xoGQ==
X-Gm-Message-State: AFqh2kq7jfUEXqZDo9cCnS41a5VzLoXGav/f3GzT4EMMwu6NpcKZQ89N
        DR8T3wOJPkSXIJD38EQNrNKZXQ==
X-Google-Smtp-Source: AMrXdXtnegZsA/OzeztSEBOwZ7uawpvx3yql8nZI7sD6Wwfegt8ck6ntGiUT65918OdLTlSDkFfkRg==
X-Received: by 2002:a05:6e02:1307:b0:30e:eb27:2802 with SMTP id g7-20020a056e02130700b0030eeb272802mr174827ilr.7.1673633929894;
        Fri, 13 Jan 2023 10:18:49 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id x17-20020a029711000000b0039ea3e0a3easm2456796jai.35.2023.01.13.10.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 10:18:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 18:18:47 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
 (=> interconnect issue)
Message-ID: <Y8Ggh6RObbB1cxSS@google.com>
References: <20220902043511.17130-1-quic_rjendra@quicinc.com>
 <20220902043511.17130-5-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220902043511.17130-5-quic_rjendra@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 02, 2022 at 10:05:11AM +0530, Rajendra Nayak wrote:
> Add cpu and llcc BWMON nodes and their corresponding
> OPP tables for sc7280 SoC.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I found that with a v6.1 kernel AOSS on sc7280 doesn't reach it's low
power state during system. This can be observed on herobrine based
boards on which the AP_SUSPEND signal should transition to 1 during
system suspend. If it doesn't the Embedded Controller (EC) notices
it and wakes the system up again.

Bisection points to this patch, the issue only occurs when
CONFIG_QCOM_ICC_BWMON is *not* set. One might think the patch shouldn't
have any impact at all when the driver is not enabled, but it does.

Debugging shows that the issue is interconnect related. A bare platform
device is created for each bwmon devices, which results in the average
and peak bandwidth of the interconnect link to be set 'initially' to
INT_MAX. The driver is supposed to call icc_sync_state() during probe,
which would set the initially bandwidths to 0 and determine the actually
needed bandwidth. But since the driver isn't probed the initial
bandwidths stay at INT_MAX.

This isn't actually an issue with this patch, but how the interconnect
framework deals with devices that are registered on the bus, but aren't
probed (yet). Not sure how this would be best fixed. Georgi, do you have
any ideas?

Thanks

Matthias
