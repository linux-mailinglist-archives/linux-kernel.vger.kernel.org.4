Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A30760C184
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJYCMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJYCL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:11:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7745140E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:11:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 21so265315edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DL9WF4Mylrfp+MwZoTZvcDrB16pT5xNMjpJ+/pZ+o9E=;
        b=Xcr237NvdUFwGP0I2dxeDaEPR4hKRZltuVVXaPy11GUSTiwWmMajjk3xtKRuNiijQL
         vnIposwOkmb16Q7QdD/4Fnvri1J7RRy0W94PUXdUYA0aPiQ/Rm4LBHdKuhJfJIns9ozh
         uzWOnXQWwf0orDNrO2NMQRjSOWIjP9udDMGLMDswK2k/9PKFSZefq5Xgb414/EOgoowq
         q4efMz/I/MVihjxZFFLbKmJAWI3coo30e0542nJqGiBorJJWHDUXt7uMaSD16Fd5bsUD
         uTREtsO9yorjf+rChGzcdUoNv8a4jyuKh2NY6yzqQ/ZD622iruvnC4tZtmYxkG2SCejU
         Hw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DL9WF4Mylrfp+MwZoTZvcDrB16pT5xNMjpJ+/pZ+o9E=;
        b=jPBwt40iLuraVSSJmjSRmQjQ2SONH6mrb2kGkQKhZrKLTw4ypheLLdrvUdv9Q/+wl9
         J33vnsE1YK3mLyVvjWm3arh7m8u5s5A5erC8u5QUakbcTw28N+zERg4NSge2zleIaN6x
         +5gE8icf4y9xsFwWBZt59d/ZBAhWsN8E2VcXXZQZ1SNc/09EhVS7jjs0BIpYGWHEibhJ
         oGZHkNonibo5KDycnAbeXvQWWh0X43AiOpRL5CzQlHDgIB40XGiemNB/pmLRrnaHlhyq
         DC0tsjHr54qWGTUHJe1RubQgNT0m5yPZruQ57zCvBZ3MxF02TdkGJezfkQbZ/+LyVohl
         PXJQ==
X-Gm-Message-State: ACrzQf1EYzjd65CyJ7ICQzkmnRleiIMb/gbnyfun2+oh9uwU1P14Cbb0
        mmVwBq8f4hnQ5KqJ/+1omrIGWsbUHltnpcwQGQo=
X-Google-Smtp-Source: AMsMyM6r/0WxlSaFvbMIXpLREHO0B1nTzh16UKpuAAXamArv+jCzW2omC3+KTaaVrDJseUx0TA/czQHDQIkqga/zdNc=
X-Received: by 2002:a05:6402:5212:b0:45c:c37d:4be2 with SMTP id
 s18-20020a056402521200b0045cc37d4be2mr32854611edd.31.1666663915105; Mon, 24
 Oct 2022 19:11:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:254a:b0:45d:47f5:22fb with HTTP; Mon, 24 Oct 2022
 19:11:54 -0700 (PDT)
In-Reply-To: <CAHjSBQZH2c_NMBNOgfxiQMvThsDohkL6SPfPj5441jHpnE7nbw@mail.gmail.com>
References: <CAHjSBQbTdhq5NpCgG1bHUrnf8hpKEPtThMxtRVaaV2zrcfq3dg@mail.gmail.com>
 <CAHjSBQZH2c_NMBNOgfxiQMvThsDohkL6SPfPj5441jHpnE7nbw@mail.gmail.com>
From:   Mrs Zhen Li <tebogo.rabodiba@gmail.com>
Date:   Tue, 25 Oct 2022 04:11:54 +0200
Message-ID: <CAHjSBQZ=W9D+5C8yW=SGeoi_BEZadwfBo5Qqjhifhywd2Ks82w@mail.gmail.com>
Subject: Fw:
To:     tebogo.rabodiba@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A very good day to you.

I have a very important proposal that i would want to discuss with you
and hope that you get back to me urgently as it's really important:
mrszhenli1@gmail.com

Yours Sincerely.
Mrs Zhen.
