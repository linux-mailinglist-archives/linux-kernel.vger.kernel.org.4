Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78BC5B3493
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIIJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiIIJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:54:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA60F12774
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:54:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy31so2760881ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=4jTliqUkmhKiwNzwktrQ9SUvY0HMDiN7hYUlvaA9PWE=;
        b=fpTVJJvF9xjy7VpFZxyMp1LFLLPxw3IlOZCH1XjnCq6gRgV011HVKr2NiP4XdavdzP
         Xf7gHWcr44lrHzLUeofDXvY0btp2ACaAPJgdnPHmqLYeGewI6CsCRHUHNIOMCcotJ3jU
         p7Zo4l//vMC/0hIj+OW/PIM0I3fpJT5l0HBooOR1+RkBU5udVwBsfMBGg4berFctDZid
         yPx6Ra0hFSKCZ8nnYAZ4G8h8NBx/q/OyI8YOBsB8s2mOV7b8U971tV97BHHXzH7SOKi/
         4WTjaO7m3KjlFdC5Dx9ttU9NWUhDHH4VkXY3xKFYwCOni5Z4K+obDUmfv5PWURZZi0mx
         AXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4jTliqUkmhKiwNzwktrQ9SUvY0HMDiN7hYUlvaA9PWE=;
        b=ezSIAhC2CceiXCL2ElTgqdERsMCpNu5+GgKqOgAwTwKdthocfPPqTICp2Ha5JCAfgc
         WLeqCwUxknhLM2LoDldtgMAR2v6jHKo1Tk6mqR1eVRJ7uqcObIFI/0rGZmk+VMsYNWuS
         1kmPrlolJr+SaeOfl1ZGR+/lIDgZRyBk5dWXLEVGeIWbltuW0rEG5XJqEqlJ7C8BTqYi
         vtWOGDAHQSAn3PZMgTH4thehdyrMYwxw14eA5C5nCVCo9puYOUP/BHUVsVinTB8wT+1F
         dlaScXB3TjhWfND9Okfqa78xFqKVvtSjQ5jVe4ytSRyXxd1Yg6VNFOVTLzaHacN7LQDO
         grpA==
X-Gm-Message-State: ACgBeo0y/GAQ0WRnCL6lP3u/np1P26gLgHYdIjqMVbz4V2jVPcW814XU
        gV6Ikyt8y6kej0Oo6bdzuy4ZD167WrrBLinh4U0=
X-Google-Smtp-Source: AA6agR5Qmvjf2A6oJa91RHcuAcm/U+5fVK6jBWFnjV7VwJaGsJZez2t0VNVxbU0ijBHcKY+8wyqVasoEyEmkOTrFmqg=
X-Received: by 2002:a17:907:3e8b:b0:741:9c2e:1afb with SMTP id
 hs11-20020a1709073e8b00b007419c2e1afbmr9196337ejc.701.1662717272960; Fri, 09
 Sep 2022 02:54:32 -0700 (PDT)
MIME-Version: 1.0
Sender: zulkifiliibrahim38@gmail.com
Received: by 2002:a05:6400:5b9a:0:0:0:0 with HTTP; Fri, 9 Sep 2022 02:54:32
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Fri, 9 Sep 2022 02:54:32 -0700
X-Google-Sender-Auth: 5tevOpHSemDljVQn4WFxiWXUvQk
Message-ID: <CABJzvcwh+LXosL4rKR-W8Lg=H5PByqzLTbYoh3gPcY+UxH-JfA@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard
