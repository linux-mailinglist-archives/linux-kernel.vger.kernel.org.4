Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18443606B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJTWQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJTWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:16:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC31D93D6;
        Thu, 20 Oct 2022 15:16:47 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a16-20020a056830101000b006619dba7fd4so713211otp.12;
        Thu, 20 Oct 2022 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/A4TsPZ5OKeQV12OXhSz51owPiznHLBKdOy5Wwbscas=;
        b=FkI1K4tshdheWJHtWR/mNvfpli11lVVGaZ6PBlI37HmO+pT1bv6/on8QsvvJrG830h
         nEEQlUrcen/NMzVdCw7R1+nDqPTPHFWbktExGjmw+uwE68Rz7NAsZp9GkNOejzWD4m/J
         SrIwGuMqUjiV6h5xaf8fSD+chPkKy3N1+0XCuKa537MZBduRuQwHUbMtMwlfKphTEiCQ
         swKOj51hRA2ccFaKW9OQCBcmz3yJox/cS+5eMMz/xDCckrg6ZrSxNHcEpRXbKa80MJxK
         IvA2hRy/XX827cTWLU7TLA3saN+tb4dCPhOGsdG0fEM3uxv6FesVRa2QBeSQLd5cJA5A
         Xc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A4TsPZ5OKeQV12OXhSz51owPiznHLBKdOy5Wwbscas=;
        b=ZM7FfcPze5xQN4p+uWJH3PhrfLduw1oO8lOpga3/DHBX3iza6YqyCSd10p3CsqSi+I
         fkzmbfl30Huta/ra9s7swa3H6rOeXXsv9nUCpRp8+j/PmX8+KO+9s4NWsbAqyRcG9O/O
         z4DV383gX2IwXgzI4j708miXBj/MMtWcQpdeXg9FKYrc4/VfoUBIZD1q7uXckMBSUebo
         fX0tcvLJYMK+//4wzpAX6+WHt0PM4RMf2YhIFNtHsHGgyIGtMxET9q4zQLJJbo04GOWD
         eMcjGdVWJeENnxz/MXKC3RKFRpYbYGngeMIxo+G/Dcy8Rb8uPf1clf9XSFbJYd4xSqjl
         tbEA==
X-Gm-Message-State: ACrzQf00m/ubgM6826P289a8EjUryEBTIjsg7IdKm2fyxGPeoPBgM7xi
        +XYYbegYt3WMrb0TGHN9F8s=
X-Google-Smtp-Source: AMsMyM5Uz2WW637gp/+mECf2Y+GTW/j/H+cLyZ95Gr0b6pCTQAqV+NnrRCCeUGEhJ/50JBOtWBQzrw==
X-Received: by 2002:a05:6830:3686:b0:661:ed59:d3e2 with SMTP id bk6-20020a056830368600b00661ed59d3e2mr8177278otb.357.1666304206820;
        Thu, 20 Oct 2022 15:16:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf33-20020a056808192100b00354948e04e4sm509464oib.2.2022.10.20.15.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:16:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Oct 2022 15:16:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] hwmon: (jc42) regmap conversion and resume fix
Message-ID: <20221020221645.GH4035307@roeck-us.net>
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
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

On Thu, Oct 20, 2022 at 11:03:16PM +0200, Martin Blumenstingl wrote:
> Hello,
> 
> this is a follow-up to the comments I got from Guenter on v1 of my patch
> from [0] titled:
>   "hwmon: (jc42) Restore the min/max/critical temperatures on resume"
> There Guenter suggested: "The best solution would probably be to convert
> the driver to use regmap and let regmap handle the caching". That's the
> goal of this series - in addition to fixing the original resume issue
> (see patch #3 - which was the reason for v1 of this series).
> 
> Changes since v1 at [0]:
> - marked as RFC
> - added patches for regmap (patch #1) and regcache (patch #2) conversion
> - patch #3 has been updated to use regcache for restoring the register
>   values during system resume (this was originally patch 1/1)
> - added another patch to remove caching of the temperature register
> 


Great, excellent work. As mentioned in the patches, please combine
patches 1, 2, and 4 into a single patch. Also, drop the RFC.

Thanks,
Guenter
