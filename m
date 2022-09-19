Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16B5BCCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiISNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiISNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:22:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0B2B182;
        Mon, 19 Sep 2022 06:22:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so6732977pjb.0;
        Mon, 19 Sep 2022 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=0nZnyZNaSM9w5+sxm06lmqmQhBWgICKccnr6F8iqgt8=;
        b=oiFXraYMLoSr5BBVwQNarFyjwQWkf1LFtAsgWqaarqL/IuT0DIvOFqUtLuZ2D9Ayb0
         auF4+5jQ4twoVo1nvFSzDcWpHqYfb0kfRdizeyhmu6LtoAnCK1pQAmhTADk+1C728kxh
         wZQj+7q0N87W1GplbTD2Fo+XU17gVNWhFYIzXOb/nsZADs/qkOqb0z3AjLBkHxL0Irim
         h5H+2QZ8Dfr++tu2yVGlNEU9ILtbYyf1iNuo5g/0kYOjmgzLjb/1dUunBxmWx+WDfrEo
         c1F3cHojTbOE7X59Y5hLuT+RErBthfu4vZtYqP1v/q+mt4Eo5tzWPtjYLMfH4vwDm2ia
         tRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0nZnyZNaSM9w5+sxm06lmqmQhBWgICKccnr6F8iqgt8=;
        b=fBun8vJ2ske+norVEz3hWqa+UcEWbladYklP5dyg94mQMgCs0k3TRASj6oy8gqy2U0
         c6TgBbJ+Vz4APuQ1ULu3XHWxr7FUR1mYeiHxHZOKdyK1EMQ+dzlI2n0YmqEiZxjMMbot
         sd030a1kzq1wUquJKEy+jORTrJQ8YnKZ7k2yvo+VzVedZ3wqx86WmbEHvg/JCxIayRUN
         m1weHrjE1swfCvnK3fwP3jQeY7iJybPiQAs4g2ghc+8h0BL+t2Rd8v6gkCFWrzSqOLh/
         zDalklhZx8dFRtQ1mELdbIDMhDXwgSkbvP4tvel0Fm6SHe1uGjmg6n5uOvFdwGnOZymG
         8fCQ==
X-Gm-Message-State: ACrzQf3hTIf20UjVhJCKgUXuEGOF37eXT6cOt8Nqn7B9NvphoP2KTz9z
        lWe1FItp4fzo6J9m3c7B6bU=
X-Google-Smtp-Source: AMsMyM5Q0RnPxIWG4uKeuP2FOHOSwvURybq1okcTyfZj3Djz4zBaCbzCqQLzIOP4HUcTwjD0adQIIg==
X-Received: by 2002:a17:90b:17cc:b0:202:bccc:f552 with SMTP id me12-20020a17090b17cc00b00202bcccf552mr31323108pjb.154.1663593736982;
        Mon, 19 Sep 2022 06:22:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b00174abcb02d6sm20494868plh.235.2022.09.19.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:22:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:22:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <20220919132215.GA3547503@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-21-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-21-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:48PM +0000, Eliav Farber wrote:
> This change adds debugfs to read and write temperature sensor coefficients
> - g, h, j and cal5.
> 
> The coefficients can vary between product and product, so it can be very
> useful to be able to modify them on the fly during the calibration
> process.
> 
> e.g.:
> 
> cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
> 4096
> 
> echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Applied to hwmon-next.

Thanks,
Guenter
