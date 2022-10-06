Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599A05F69DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiJFOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJFOmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:42:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FBFB0B0B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:42:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f11so3052956wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=l2gnFSFPSlRjaIYrHodxPWa3mPS8gpS3VL5ic+NAZDAXyOnk5V+Xdq1Dgn5Dp200Hc
         JWlTMbTyTWesteuPQvbfdpcheRJrGZRoVGYfudA9i/O6WQSK5jqH0lOQhyZLph79GzUh
         NWpi+wGlnUH24IDERjfS2iSCVEXPI2BPuCpIiS8mjO6yZDBGS4yx1onSXd/uzPekccDY
         IzwCLklIBe8frcYrTJ6g5NIKpMHD0Sosh29Y0GCaGFzVMCUtnfx1nIz0vnnASKS31GOy
         iPCUAM/rQSQ9tw6L5eaZXs/0+s7Ndrc8E1SmWs97mkGsWIyDFKyf0f4JDfMqvbrV8Tt9
         uNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=GzhgdaOLudGrQo2L3HIV8hKvdFt+9gWlnAcKEeQD2hIEwWY5Rkt3jDHbTixMTN/1tJ
         JQmPXN97NpqYBgHgyLLqWUKcBQ0QqLbDGVV6HkQugu+1vxvTi+OFxu/Yz4lrUahIzjAz
         1SM5lRD9BkS52RsXrnNN0kKtU5/2KVZwxSZKMzbe28k4oZs4tOdzf6NkYtuXIxIq70g/
         qpAZjLt1bjbL9VxRNsZ6LUYiNwndxC9eP/CKTGIOqrCHxsC4UWCCsLn3IlhCEin0JTbw
         OfZ3oHFclxqJ7fOUxPU60HwOKViPUJbmCc4musbK2zbusXH7GAS60EcFolQTNC2mici8
         jclA==
X-Gm-Message-State: ACrzQf3s+p9tn9yT8Z0W2X3Xkew9/Wbf9iIm5Zs6jssqrZ3ELHwBg9Hk
        XgRl4Vv/zwZbQMIVddTMcaC+ieyKNgrYgPceshs=
X-Google-Smtp-Source: AMsMyM7o6Qaq+wE5sacAWhfflIWdQZlEDdIz94f/qzsQMcSRjrRMx+v8NKi2m85icARiW9ISkfKtUfTiVsowLKFNNoQ=
X-Received: by 2002:a5d:5847:0:b0:22b:377:6786 with SMTP id
 i7-20020a5d5847000000b0022b03776786mr193974wrf.568.1665067358627; Thu, 06 Oct
 2022 07:42:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: oenenhayrettin@gmail.com
Sender: ff7392108@gmail.com
Received: by 2002:a5d:56c4:0:0:0:0:0 with HTTP; Thu, 6 Oct 2022 07:42:37 -0700 (PDT)
From:   Oenen Mehmet <oenenhayrettin@gmail.com>
Date:   Thu, 6 Oct 2022 14:42:37 +0000
X-Google-Sender-Auth: zcsaim0rojJjZpW2gxjCEZp1ax4
Message-ID: <CA++Sywb1ZhTXTPr3hb5-bD=gS8KPgDuX+8HL7qTEACU2sTr7sQ@mail.gmail.com>
Subject: Hello. I contacted you to manage my new project in your country.
 Reply to me if you are interested to manage my project funds. Regards.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


