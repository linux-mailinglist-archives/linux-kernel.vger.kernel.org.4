Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383B5B3C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiIIP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiIIP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:58:43 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618801079E4;
        Fri,  9 Sep 2022 08:58:43 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k2so1019403ilu.9;
        Fri, 09 Sep 2022 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=n3Wqn2s0TJTlrmb9EBoDkbB2XMyMqvPucuQRmNhgNPQ=;
        b=n+eLxUloJDsZq5jafckZ8/Xo0NG+9wl5AxX7WTK0OJmiq+3upZsuyE1on4AVd1ADJd
         bdkYLSvne0bM6gFLV7C1YhHKNgcSxnthcfNcbD0bePrwcZkqokgPNluADxemR8VuOLn0
         tD9Z/Ekq2KNSwJ3xecDcolLAOgDgeyQ9TG759xFlUjWw4+IVH06kdq3XCjdDFMyLRxc3
         BBMOjlgBEkZtjoXWS3f0ipQaXOURIdjoHE94LIgbZxHVmp096tV0vASN4vZ0Y/s17XZD
         GsF2dcSPg5QrvaVstOKCNPi0vxhWWVOHGPPlUY0RmgjS4ppVPkWupmO6yBCFyGE0wRwe
         SzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n3Wqn2s0TJTlrmb9EBoDkbB2XMyMqvPucuQRmNhgNPQ=;
        b=b5VOm1D11y9eQYc0TMFfusu/1m8zCdr3rgiXxIP/DS7GYMW6R3sPFa1TWwxGpdzG/i
         nkClzIqm4ZHNK9UICvci5QSt37JXmCitAw3KJStkVeRifrbCRNLMfX0/TfvN/4cvikxE
         iO/PKzrb/cVXHkbAnMci+Hi+vNir6RZSa0seHU5m9rA0RxURIvS1YoPOAHCWj+ihwZQj
         x0aW9YYPsyHVICVUPkOQ8SWIXImeNuSSp/scPNztkDJGsfU3lAAuxj409G44XQfV/UyL
         7h89t4hbU/pt9eaQLvyoMzAS17/qUdHW2hmXdBzDlQk3DSRq8ANbaAX4eGIO6jCjnwbA
         QN0w==
X-Gm-Message-State: ACgBeo0t7Pm56WVMZ09ne7dRmN3I0A48fr8I5zg5zmeOk2FC76n2TRwZ
        oO9B4bBZczUNCFnd3BXfbpnS6SKBzVosVnVZJ1EoNGK6720=
X-Google-Smtp-Source: AA6agR7M38yqwN5cUefBMPZoV0Qo7N4m4FCY1kQfM7U86ZEXAO0VY8OMPwe2fvA1yj2mPOsgMkKoSl9LVp1lnfGzkaQ=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr4530008ila.164.1662739122766; Fri, 09
 Sep 2022 08:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220909155446.122937-1-eugene.shalygin@gmail.com>
In-Reply-To: <20220909155446.122937-1-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 9 Sep 2022 17:58:31 +0200
Message-ID: <CAB95QAQ3Dv5E5ajQWnh-jOM+wYzcBgdBT=KNeJ_Q-eqj1S4_2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] hwmon: (asus-ec-sensors) autoload module via DMI data
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sept 2022 at 17:54, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> Changes in v2: remove the clenaup_device function

Pardon me, v2 is broken (forgot to pass path to git commit --amend).
Sent out v3.
