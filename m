Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD0614E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKAPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiKAPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:19:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9538A6;
        Tue,  1 Nov 2022 08:17:37 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h21so4475141qtu.2;
        Tue, 01 Nov 2022 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SWkLMt6yw7tvNdAQ+/EzEXzyA5VXlAKFgyL/yIRZhHw=;
        b=MWS7cus7lOm6wH58c8DqvyVXc3UsUfrPsugaKGsiF0Ho3CXKMvuvWnZkiOqRUfCexH
         8eb+E6v3rPOrWTRAkeF/ZfFdsyL6L1fsDLcts3s4mCuB1naRaUpCGE+Xswm/qdXGsYtb
         B1vvDLGMpQH1zQ2X86/HMEKIntPJMG1VpUXsJb+NEMeZc0wZgbuqjsX6XzgEWBm681mP
         zapdsZmkEHeKAL2oHYk5JaeCo+cC4Aj2F14e1APtH1ebslZhTZ5V1GH2mUu/sDsitm7E
         lJTCjPyWBD+cgyJa/o3J/ecJC8e9xF5FV3wluZ5a2RBKvmrX/1Z50tgabWK83vboVW2z
         MThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWkLMt6yw7tvNdAQ+/EzEXzyA5VXlAKFgyL/yIRZhHw=;
        b=VUml8JVj+EVvWNbIAuAZMhgGATnB8SKI+V7idoicQHDJViF46HV5ZHCuKf6+Dml6la
         zgyFWhUKnnEKkJBUIWZzm3GzlD9frAkfBZFKVTVRWARZnF8tALcD8YJFHXYp0U3Jg/CX
         k6Mn/JXvQi9UqCVsnM/so8clrOkUkvPIzIJ4+Wb4J8UZ5/Dclaz1nJNd61C6cZupTSKU
         BN9xtB6Xmz9KMCfwSm2bxsOAvTvNMHqqe2C2AyOgvXrI3L9zBEmMjMqD/X+ljUrnKxfZ
         lpXc2PmZvoM3OYfpvV1DJTWiQLjAxTlqjGv3V3SiWs7YyY2zk87XtHVo929Vi9eVxN0V
         c9pQ==
X-Gm-Message-State: ACrzQf0nEa55kE7IljoN8rikHNipLdBqvCup146oW9dMFRJBjL8Y2vv5
        vq0j5E5jpRoK1DBkU2kBsIx8NmR13UZs7/dTN2I=
X-Google-Smtp-Source: AMsMyM6vSw74E3PO9MtWs/btIIS1SlHO14WoxJrm56iYXH6FmiZqpoEp/Ksy1I4R3zrESaL/LcyvNgnyd1bH1yZJjYw=
X-Received: by 2002:ac8:7152:0:b0:3a5:2fa2:cd1a with SMTP id
 h18-20020ac87152000000b003a52fa2cd1amr5961872qtp.195.1667315856570; Tue, 01
 Nov 2022 08:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
 <PH0PR11MB509629C9B80D4331AAF0E5AC9B379@PH0PR11MB5096.namprd11.prod.outlook.com>
 <CAHp75Vf5sBJiNQckCxDGCzFWBYnVs4BhP9+m77_6guZYC+Cybg@mail.gmail.com> <PH0PR11MB509684CE1142854777FAD9979B369@PH0PR11MB5096.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB509684CE1142854777FAD9979B369@PH0PR11MB5096.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Nov 2022 17:17:00 +0200
Message-ID: <CAHp75Vf4DdDX_=9XZsocKg3k+SyCyYZ1i=9DoFxic4rOe9x2hA@mail.gmail.com>
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, lukas@wunner.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 5:04 PM <Tharunkumar.Pasumarthi@microchip.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, October 31, 2022 8:07 PM

...

> > > But, if I do this, I cannot use sysfs interface for updating rx_trig_bytes right?
> >
> > Maybe, I don't remember by heart that part of the code. But why do you
> > need that ABI in the first place?
>
> By using the sysfs interface, our driver will be able to update the trigger level for the receiver fifo interrupt at runtime.

This doesn't answer my question. What is this needed for?

-- 
With Best Regards,
Andy Shevchenko
