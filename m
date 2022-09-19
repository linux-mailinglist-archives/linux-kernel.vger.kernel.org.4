Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817E05BCC66
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiISNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiISNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:00:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C591F2E9;
        Mon, 19 Sep 2022 06:00:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso5993352pjd.4;
        Mon, 19 Sep 2022 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=NfuchXeNrOKh8kdwfHXDqWJgnyXZRxJ0XHbLAPBkfk0=;
        b=Q+ipgYkq2IQMa4g6oDXeJ//TY9hNJB1iyqW4sEXpLjjzkZZN7Mt0UFXIZWKVaGycd0
         i88So5zwO/TAYU01561qACkiy+w4bdI1Yvi4dOTI+7tONTIq9LPQY/+DSRj7s4Zd9/Pl
         e73FVPZN1GY6ypROrMW/5H7GxifBoTxkPN+gco5e0R7nno3FTJJef7Gy/AVhHTUbhNl7
         tj3DKqxuCvE4QbFh/ufU1DPliz53aZmW4fGObcWUQblAIRbKgKAnUb87xZG/gDjyboD/
         PFO76FFQq+CMF5wShxvE70WZpDsgvRaZqMpLxolOwBuGt3BIJ7RphxRr2ketjYQdyTGN
         6T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NfuchXeNrOKh8kdwfHXDqWJgnyXZRxJ0XHbLAPBkfk0=;
        b=y0ujy0N5gVGKJ6T7Muy0SB/JOq4NDAycC2aNATLTu6EszK3PyBl2RFUZ721KKZReaB
         QSgAxu20Jb0919W81rQuiw8KQugNm6SltZCX81f09oG0Pk73LM1QRW1kuMriHqoWTdvy
         qUybipZkYd8ZcT2r3EVdqqAMNVx5F29yyCEjxjf6p1N0GtAeixjw7jPI6az626UiLGWq
         c03flFC1wMLNHNh+lroJ2SFsoqF/NUsLr0vccVXifpSKGJXp0sDeGc09+6gqmAjVzQX8
         ItKDHpeErbd10yFhutFGleox0Mc4Sj0NwyHtCCviu/fPFeezvyns/3OSdZenzpn0914V
         PxDQ==
X-Gm-Message-State: ACrzQf0bG+SZcq3XZ2/fvei6PP1nbFoajb1fJD5cK+BzWE097AovASzD
        ri5ZI/f4aFW+PeifrzHYJgg=
X-Google-Smtp-Source: AMsMyM4ln1JJOEZzXkFfCUhBosgmEqRr3Fb2Bqp/Z/J41m28LmFFeETWCjAMD03AMjSnTxyX+Y9aVw==
X-Received: by 2002:a17:902:7294:b0:178:a2be:ac18 with SMTP id d20-20020a170902729400b00178a2beac18mr3908219pll.93.1663592443832;
        Mon, 19 Sep 2022 06:00:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902cf0f00b00176b5035045sm20488345plg.202.2022.09.19.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:00:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:00:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 12/21] hwmon: (mr75203) add VM active channel support
Message-ID: <20220919130042.GA3544513@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-13-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-13-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:40PM +0000, Eliav Farber wrote:
> Add active channel support per voltage monitor.
> The number of active channels is read from the device-tree.
> When absent in device-tree, all channels are assumed to be used.
> 
> This shall be useful to expose sysfs only for inputs that are connected
> to a voltage source.
> 
> Setting number of active channels to 0, means that entire VM sensor is
> not used.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter
