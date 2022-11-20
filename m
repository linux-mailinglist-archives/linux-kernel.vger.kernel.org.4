Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4499363149F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKTOOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 09:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 09:14:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694361F9FE;
        Sun, 20 Nov 2022 06:14:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z6so5931718qtv.5;
        Sun, 20 Nov 2022 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRurPD3dxAgJDwueyUw726M/HmNgn8rlVg8EEi0jmK4=;
        b=b7//zC14ynpX3J+/pUn58m3+or6w52NB8az22w1gs4RFL3PFs6yhFZhc1BU9NryZ/Q
         zLKGX4p+z570YgjJgH6wTHHGOAmDumfDoe50autvOooPJQN9rGIGcoMfVIjCn6L2ydSl
         22ebXR3EBExfH1mnEDPJzT/qPSDgSUvu7WMbPworU9ba0dLFp15VjKOy3eOosFm8NkQ1
         M7+nXkX4IxB+J1FnfQXtb9td+R0p3bZUG78vcokiTiWdI7tIngbR4+c8ioOBg2S6ia/z
         DojD+nKlGNBfYeEUhsaxn8RnO03Vfxv9D9e1+RQxdMUEPnxTCwwmdUmXJPHVL8B4HeYD
         +GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRurPD3dxAgJDwueyUw726M/HmNgn8rlVg8EEi0jmK4=;
        b=g/w+2KiJwVt5W0lZKc5Q2jegZu2s499OhImfrtGo4wBKoTJl/+8iIYfVaJrY9L36+5
         F3nm23DsyUe2k2G11NsKKVd/YgOJ1DA8C1jIwgSj+YF4WKKuHirn4I++F202KWOB36ps
         6tKbyZ4v5Bw/a6eD+3G+UxmpE5hqBFBBjug41of034voTkH33MTQP7PM+uIaiGz0Il+q
         xakHdpituOBPIbDtc+l0UGgD0ZPR9WPEuIfcLdJTKCweml+tREOnxUn2xvBQKaWPAdXr
         ry/mrx5ETOTBRrkxyVUCeAMkMifk60Kd/QhL73691xNDIo7VGiWwDwoS6YdJ6iUpKvWN
         0fcw==
X-Gm-Message-State: ANoB5pm7tYZfM0J2VSvVTkAgyRB5ytpRe7ZgzB5u+JpTK+698MNulosY
        M0cmpwem1F7m1IXA+1pS7OxjrGlzFDQ=
X-Google-Smtp-Source: AA0mqf4J+4vwOG8VMG+PmvQo9n5pOwCcJVDUWebrJIEQ770JQVq0RUDi0Q8ES06/8L2LT5oFkM6Mcw==
X-Received: by 2002:ac8:4243:0:b0:3a4:ec88:4985 with SMTP id r3-20020ac84243000000b003a4ec884985mr13918970qtm.521.1668953674548;
        Sun, 20 Nov 2022 06:14:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006cebda00630sm6366684qkk.60.2022.11.20.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 06:14:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Nov 2022 06:14:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (pmbus/core): Implement regulator get_status
Message-ID: <20221120141432.GA1790249@roeck-us.net>
References: <20221119182517.2334156-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119182517.2334156-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 07:25:16PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add get_status for pmbus_regulator_ops.
> 
> Changes:
> - use lock throughout the function
> - Avoid line continuation upto 100 column
> - Optimize use of & and | operator
> - Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
>   respective status register for fault.
> - Report regulator current status.
> 
Change log should be after '---'

Also, when looking into this, I realized that we already have
pmbus_regulator_get_error_flags() which has somewhat overlapping
functionality. Would it be possible to utilize that function to get
the error status instead of more or less hand-coding it ?

Thanks,
Guenter
