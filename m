Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED772AE26
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjFJSoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFJSn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:43:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4213A80;
        Sat, 10 Jun 2023 11:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686422634; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=asBfk+JTn3kmbbKzvLwZZkt+t+hUl+8Rp9teCSFRKkXTcfJdAAne0bD+ZZHeQNv9XB
    yBEgmD4tsX0nfh/CCMk5MK9FtsQdvEV1uQr4tDX3EV5l0MibytA5FhJ8zGv7V6syb4aT
    QbcQo4AJfRACV1A1hyvPsW5UiPyLMXpC7R9IbtAl2+TWXe/nvm+SEpNB8NrM8rDkp4kk
    EszIpfeygxlyjbrPmXaHwg1GOZ2/WQxUI1XwavVvlqLBiAoxbrmx/AFNAXF1tjKYEjIM
    JBdqlfdZ8c2pDRND5w6e3ZN0M2D5CLJRp7uaXjbt7a6kjhwP09WECc5Rr2L+zSe2EXHF
    r7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686422634;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=S7/IDhnf4V6vN7TW7QvV+Hg95m/AA8lfZgRn14G6IEk=;
    b=Wu6p/he0znPWIGktuHRwwvwzm+7fn8v7N/wOCXeoE0uoM30pT7iIJx1kSbFJOsmIif
    cJWqSX/ZSFFZRafxyxj+RYH28opYp9GvmsoF/ZSU/kDmSjHi4N1XLi8YB1tA3YuGTLhX
    /cqmej4zu66Q7eQwAKuDlPQsH9lyMFQsZ29hZtV0pJPjH+9fZoYS9UzoDnvEBL6Fi43u
    Uv2I3Pwh6ovT8DhBAu4HVN+W7AtPADiwBQ8T+ejIwdip0Sm1Y0MY1QqkyUrhp5lvO5Wo
    K+Ti+8g3bha/q4fT3LDwMMWhQNiR64S5z9uBk6tkNoN9J0ZZmADnApGwDRaqwqJuilch
    9D/w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686422634;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=S7/IDhnf4V6vN7TW7QvV+Hg95m/AA8lfZgRn14G6IEk=;
    b=FHa2iAmKqKH5gj8F1eho5DxAm03wIs3t1/NJMQ5HuB7lv+Y+Iyn1nJSOvsMeSjvmiB
    WqvCEm/MUF2jfp+OXYEdfyv1WiBcV/gItaiSYi2wKNxNGH1yTxEGSNU6K03fW6Z6Qot4
    /YSvkNMqZJSN+kTEnX5KYa9bkmBxN/Io2jdTLj5EhVriXBP7IfHEJ3BHay9EYdvNnfp4
    Axv7wgnxuK+8S7IeWVrURuvogZgoe3qAqJJABpO724B67mgVZvVYvmLSQnhAQBuvU21z
    GQWH9Jyo42BLIghcPMRWdR8bxS9QH1goWnQ1+y6zNWXcQqehYLqmjAgvrYrzKTlm8DVl
    D72g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686422634;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=S7/IDhnf4V6vN7TW7QvV+Hg95m/AA8lfZgRn14G6IEk=;
    b=a9p/de1o9mg/6v1sNoU8iqn58cKzLRWecUKhbUAw0FQJE85HAHKOfbwIJ1FGsRhNsq
    eST8dmACihnRPd2oCfBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AIhsQd1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 20:43:54 +0200 (CEST)
Date:   Sat, 10 Jun 2023 20:43:53 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 20/22] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
Message-ID: <ZITEacAtcaZRY6ib@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-20-e5934b07d813@linaro.org>
 <ZIS6LK2lnlnNygX7@gerhold.net>
 <e9855fca-cd90-202f-aab3-caa323c33ec0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9855fca-cd90-202f-aab3-caa323c33ec0@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 08:28:22PM +0200, Konrad Dybcio wrote:
> 
> 
> On 10.06.2023 20:00, Stephan Gerhold wrote:
> > On Fri, Jun 09, 2023 at 10:19:25PM +0200, Konrad Dybcio wrote:
> >> Up until now, for some reason we've only been setting bandwidth values
> >> on the active-only context. That pretty much meant that RPM could lift
> >> all votes when entering sleep mode. Or never sleep at all.
> >>
> >> That in turn could potentially break things like USB wakeup, as the
> >> connection between APSS and SNoC/PNoC would simply be dead.
> >>
> > 
> > Nitpick: Apparently an "active" vote is applied during both active+sleep
> > until the first "sleep" vote is sent. It's documented only for
> > regulators [1] but I would expect the same applies to the bandwidths.
> > This means actual breakage shouldn't have been possible.
> ..unless some part of the boot chain voted for the sleep set!
> 
> I'm not sure whether the regulator comment also holds for bw, but I
> also don't really have a great way to check it.. Would you want me to
> alter this commit message somehow?
> 

Hm. Well, on a second look you used "could" instead of "definitely does"
everywhere in your commit message. There is a indeed a slight chance
so feel free to just keep it as-is. :D

Thanks,
Stephan
