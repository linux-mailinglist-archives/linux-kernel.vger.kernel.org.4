Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2747140F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjE1WJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjE1WJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:09:30 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F70B9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 15:09:29 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 4b2ccfb3-fda4-11ed-b3cf-005056bd6ce9;
        Mon, 29 May 2023 01:09:20 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 29 May 2023 01:09:19 +0300
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Support Honeywell mprls0025pa pressure sensor
Message-ID: <ZHPRD0CT6K1IYgV4@surfacebook>
References: <ZGNpZM137jF5yzie@arbad>
 <20230520172405.0e1a3ff8@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520172405.0e1a3ff8@jic23-huawei>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, May 20, 2023 at 05:24:05PM +0100, Jonathan Cameron kirjoitti:
> On Tue, 16 May 2023 13:30:44 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
> > Support Honeywell mprls0025pa pressure sensor.
> Series applied to the togreg branch of iio.git and initially pushed out
> as testing for 0-day to see if it can find anything we missed.

Hmm... Should the comments I'm about to leave be addressed as followups?

-- 
With Best Regards,
Andy Shevchenko


