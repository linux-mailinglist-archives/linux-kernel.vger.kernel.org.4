Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A451F6C484E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCVKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCVKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:53:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2F2CFF7;
        Wed, 22 Mar 2023 03:53:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16so13780513pjs.4;
        Wed, 22 Mar 2023 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679482410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqQAPl3A1XOZ8iyikzi89ZGyjXXZxla/FOKtFxfUhjM=;
        b=K3Mn2+d6Xa3ZqevxrA0wDRRWx/52AqrQDEMBO01p1keaWFDgmFPRNRyAZc0IVN0Rjn
         8DnVFguo+JAEz2tdSW6Z8YtA+ZTnZtxVTVYq9fw9GvTw0rRD4rfJ0MghdRQsBfxW3F+q
         6/I7OQgotBOt6qHCg8ofaKhXyDbzYjhMHYX2GSqlo3Af4akCtcNoIOUy0AEEKIJtzhpS
         oQbqFkLR62tq3EHQNplakcjRcJXjLj9Wmx3v59c4ouY4t1q4i23DZcrsd11tzdMUO2QC
         rZ7MDDqytEOiVoYEeKn5WxaiEzyhqMBZ/Xhu8KU7AUJOF9puKo6OH+Lt3yjMgjRgNdIE
         sIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqQAPl3A1XOZ8iyikzi89ZGyjXXZxla/FOKtFxfUhjM=;
        b=TH7RFay7LwvpW2zEn57p0qUDkgLowC8/pYR5UGFYtfGDJ/48myVBnUkNYMjRGyeS3E
         c9poBOqpsP5ENGiBFsDbGceFmx6RY0/A3/iHuka7DX/+1idRkwc9I80hEO4wi011oZhp
         CExt897j10f3DWWdmgBC0hmcVLeJbY4Mx3wj5Kw8nKew31fSjjP3RaQ9rriNNFO6iRIB
         G8JRv+hqlNpRvAxhQEUq5iobSlCbLHROB3qLr3arZoQyYyPwLzweR2zHRXzCDAMeBoUd
         21SEsUqn2lQIIe7UyJgwqlEaORoZ7f4UEDTCXXbmyVsOMU8ahB/tz/yEAVm7INvupr7n
         w0RQ==
X-Gm-Message-State: AO0yUKWvLbVI5TZDI98Z4FO7g9EC3b+LfzJCMyNULJqtMfEa6n37XtnY
        pOFQtXN0zOcQByMucgx/zzsdQiHsOwqv1cgDmr0=
X-Google-Smtp-Source: AK7set8QQ7Xw7Ny4rl23jd5KMcfCQw2Vug1lrdf6EY4Vl9meorcrTaLKUd88bZLVxAqdTsj1h8yEzfMsHT04pIGBp10=
X-Received: by 2002:a17:902:bb88:b0:1a1:cd69:d2ea with SMTP id
 m8-20020a170902bb8800b001a1cd69d2eamr843676pls.10.1679482409862; Wed, 22 Mar
 2023 03:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
 <059bec3f-0c77-fc16-83a3-d78cf82d543f@linaro.org> <bb56bbb7-7b08-79f9-ad1b-a2de63eca5f6@quicinc.com>
 <CAOX2RU5H=fmxjAE+Er8n7qzrvUZmOpYwgqFox-RLc2C7BqJyjQ@mail.gmail.com> <0bad147f-46b6-c52f-536f-92eeba8896ec@quicinc.com>
In-Reply-To: <0bad147f-46b6-c52f-536f-92eeba8896ec@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 22 Mar 2023 11:53:18 +0100
Message-ID: <CAOX2RU79jGYc0wV4t0zbQHKYWtUFmTUzMGKcma7v9BMSt09X5A@mail.gmail.com>
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc driver
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 11:52, Manikanta Mylavarapu
<quic_mmanikan@quicinc.com> wrote:
>
>
>
> On 3/22/2023 3:51 PM, Robert Marko wrote:
> > On Wed, 22 Mar 2023 at 11:19, Manikanta Mylavarapu
> > <quic_mmanikan@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 3/7/2023 9:09 PM, Krzysztof Kozlowski wrote:
> >>> Why exactly do you need a new driver for this instead of extending
> >>> existing PIL? I feel all this is growing because no one wants to touch
> >>> existing code and merge with it...
> >>
> >> Previously we raised patch to add secure-pil to existing rproc driver.
> >> Bjorn suggested to introduce a new secure-pil driver.
> >>
> >> https://patchwork.kernel.org/project/linux-arm-msm/patch/1611984013-10201-3-git-send-email-gokulsri@codeaurora.org/
> >>
> >>
> >> Also IPQ5018, IPQ9574 soc's follows multipd model. So we decided to
> >> have new driver which consists 'secure-pil + multi pd' in one
> >> place.
> >
> > Would it be possible to have IPQ8074 and IPQ6018 support in it as well?
> > Cause, those are supported by ath11k but remoteproc support is missing,
> > I have been upstreaming parts for IPQ8074 for years now and it is usable but
> > we are still missing remoteproc.
> >
> > Regards,
> > Robert
> > >>
> >> Thanks & Regards,
> >> Manikanta.
>
> Yes. It's possible. Currently we added support for IPQ5018, IPQ9574.
> In subsequent patches, we will add IPQ8074, IPQ6018 & IPQ5332 support
> as well.

Great, that is rather nice to hear.

Regards,
Robert
>
> Regards,
> Manikanta.
