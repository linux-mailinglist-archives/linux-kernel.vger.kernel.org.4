Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0535960E40E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiJZPFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiJZPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:05:05 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E271BFC;
        Wed, 26 Oct 2022 08:05:02 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13bef14ea06so6596435fac.3;
        Wed, 26 Oct 2022 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZ7K9c/DhvA3ULMMun0jLi/og1DertsN4XABD8/KyjY=;
        b=EYk28o/biKU2YVqqaYQpWv1EveGWLGPZ87M0sCOrsphee60eFxn4SI3TY+rZW4nGqj
         lCigbB0P9z1A1E0+/e+IGWIcvBSuvDJS1iyptl93MVHuda3AEOoQG4WMsbH285U4o9bR
         VryT/UVC1eP7/pzFHkIwoWsDt6seiiEIPjZzySUcgGK6zmxnc1z0C6IWDzB0J5scBRWz
         Usb7co73sSqu/19GPpN7vIqe+lOoj/IcdPgIG9LJk3a9lGh76GpN9MQrT/5ADt2wdWRy
         7bWDwbmcaGmB24oa37dJ9N6pU9oqDV3hM2a8zTY4Ag//EbPfm5JFWMNh49omycESMnQn
         aiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ7K9c/DhvA3ULMMun0jLi/og1DertsN4XABD8/KyjY=;
        b=gw6xn5yaKj6hKefx7V9RREIKQEFH5HDdpjjIVL62t0Co+YZKt3MyBmpRDxp+pH29cF
         LRYpm7QL9fuziWuu72naPaDdw9XCYZfSNlrxXIDt3QVoGHNp75Zikk2bqVl1oZOiMC2Y
         62kU7DJV2WEprI+7A6NrhyZwkQdYRnq9u9nn678gv9xTC7V9BnCDdMH1njbQMJIPDDSq
         e2iyAlUW19atu1qDdatlakehCe3R25uVw0UYhMFhET+N7Bah11Xp1xxMrj58Z/cQgMPt
         5Wt4PTG4dvuWSPnzrhrDwYQzQv+T+WRHRpIqLi6MdRpxnaEVGGkmM2mjs2PLhPfZJ9n2
         VhIQ==
X-Gm-Message-State: ACrzQf1pPuYhlA+dmOSMI8wf66SYpH+dVooW5+6qAshoWEqBf02rtxzX
        ZUAgW/OYoECaa0EdHFabXvvOAaMLLWM=
X-Google-Smtp-Source: AMsMyM7j+pvR/AINPyg0/WuDkBDZdG1TX/POVx/pzR6NDVfhn03EqbpG1ODcDrEDTVnVovhjTzYTDw==
X-Received: by 2002:a05:6870:5388:b0:132:dbd1:219e with SMTP id h8-20020a056870538800b00132dbd1219emr2436570oan.87.1666796701714;
        Wed, 26 Oct 2022 08:05:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b20-20020a05687061d400b0013b1301ce42sm949003oah.47.2022.10.26.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:05:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Oct 2022 08:05:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for
 temperature sensor offsets
Message-ID: <20221026150500.GA2546211@roeck-us.net>
References: <20221024151039.7222-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024151039.7222-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:10:39PM +0200, Aleksa Savic wrote:
> Add support for reading and writing temperature sensor offsets
> on the Aquacomputer D5 Next, Farbwerk 360, Octo and Quadro,
> for which the needed offsets are known. Implemented by
> Leonard Anderweit [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/22
> 
> Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
