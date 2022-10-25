Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157F60C515
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiJYH1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJYH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:27:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E5C12A98
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:27:06 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u15so13266611oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5B7bKFkZRY4NKqw2lwBJxw9pImgF33Js7bmEAFE6Oc=;
        b=Pla+H2/4t1ZpDa49wEffU/4gseJNzA2FnE4OJ1ACPXrzcLr5OALpPiz7IDYpkMcHE/
         5KrbxeQAD0GyroACFCSiWE+6e8MDX//twTOWxySyLp34k73PjgG3G5WnIQZ4uk3462Kd
         MGb+0vFKlUKAfSUqTwYc4m/S1eRHD6H48XL8gYIXa8l29ho7wZrIbq6d5dZOuFsAVto5
         OZ2wxJcJEFCiwBZtB09J86NXautIrh0MwNGIjzcjU0rrUtbgmEcqyftPKW/1qCaLQPnV
         NVMin7FTRP/CLmqiwuMO1TDivnt14ElXJTW2DzG4yanyRGFOvXb+/MmefqxUmT/qQGJL
         EG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5B7bKFkZRY4NKqw2lwBJxw9pImgF33Js7bmEAFE6Oc=;
        b=mp+a8+y49QgiHSddes67u7OcMRpWHJUTooyd8+GMtFDHQdfv7ziOKj62WX9/eSJixH
         X7MnSRu4Cj9e/jnGb3JZJSrYyQk+Odd+1sYjWqsyobLZ5Oa3r6Yq5+V0oQERaO0hvW62
         lewqQ0l9cjJoWAuPPDGFSwf5q5UtT7xBh3O2Qxfy10JLDFKdqbuGAacEYLGrRh3itMuY
         Kt/OrIUKmBy7qh+prL/8Ds6m0uJaSSZHOv51ieHJ5Uunxc59wM+xPwnstKet9ShPVYro
         BCgyinDHwmF25dOM7xZ02QbXslMCM0LNd0/hoLEQuh0rSwsAJEXZlykeRytYaV6L/AMD
         pHKw==
X-Gm-Message-State: ACrzQf2HoCsq3rpKjGHRx8XNvhY7BvYMIKNB2FuxM0ANh4pN3X0A2ppD
        QzXeGaNDcEYfo8QFPullNch8/TPy/3dTPvYpivQZlDIh4mA=
X-Google-Smtp-Source: AMsMyM703fzrjLoIhAKuVdfR2Esi60KeM6ZTnWVi/QUhiJBZZHvhileWiEFY7H5IRxWG+boy8AVypsW15v9zb2w8A4w=
X-Received: by 2002:a05:6808:2021:b0:354:9a79:2f5a with SMTP id
 q33-20020a056808202100b003549a792f5amr35575066oiw.276.1666682825570; Tue, 25
 Oct 2022 00:27:05 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Maser <jonmaser8@gmail.com>
Date:   Tue, 25 Oct 2022 00:26:52 -0700
Message-ID: <CAF=mWJM8qEvX+6Q7uqNm-vquuc3b0mVM_Hu8=qkCb-v=DxcGpQ@mail.gmail.com>
Subject: hey can someone bring g++ support to the kernel?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

or c++? its as easy as changing a makefile and changing the bzimage
code i think, some dark web hacker got me so i cant experiment
