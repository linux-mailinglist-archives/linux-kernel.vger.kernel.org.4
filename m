Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57D62E3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiKQSMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiKQSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:12:16 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB677FC0D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:12:13 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.43]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRBac-1oYYAc40d2-00N9JG; Thu, 17 Nov 2022 19:11:43 +0100
Message-ID: <dd05ca8a-c60c-a56f-66e6-9892cb933315@i2se.com>
Date:   Thu, 17 Nov 2022 19:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3] vc04_services: Promote bool usage
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kieran.bingham@ideasonboard.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Umang Jain <umang.jain@ideasonboard.com>,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221117160015.344528-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:v+yHu1Uvt3QU9GBLdXtKiy5Gtp6DZtAd5x9kAsCbgZddr7sCpwW
 YgpqInjBN5e7Jg8gHXUNNDDAojqouRTvvRR8Ou1F8zfpf9QSp368awubWM2F1sxb1D7o+lG
 KxOXQVJ94H0QY73UzYeYAmRJT+dxCn4GJr0UpXWw+u0vxTZt6K9YRpP/Ek91socwXkNlwl1
 mc2rBrqoCUX1Kjzbkrk8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a6bVZyG4qA4=:opF8oSfOlQzjzSn4Hu6PHv
 4Em422zZnieWf38nqpC/9aAx/pHP1bKBGdDzbol1N8MdSh2tC575lzg9qP5saCOqlzYg4giBL
 EWBlcPOf5LiyCb5NO4V7nTQJunaOaU2gh4TGdlaeO7dUfT2dIHbvfjuZjEirZUhx6O3GfqhG/
 8FgM9y2T4pABvhWUM9s2N24S8kKFj8IjrALdzwF5vxcbVjg/yYDwHhmXE0IMXB4ibmxscNb/j
 3NoV2WB6aXdG0ksBdYlBj3MXpaGWyuf2DltNeb92II4lqBtvBKyKTYZ4embUWDomwb7kDIsjr
 31x82j6HDb9Sxspv2XsoH13Qfbv21jMFA8Txe8DxQ4efPPHqsm1GtWuAnPo7CIjrw8hySz9x/
 EcBlCl1/qs3xCveCZbPIb7wRwqsoYupAzMk2rxa1d/nVNuQMnzmj2wlFNeJi70m5to41HN0NS
 WVKSBBFgmgMwkwhdMvC4k8kXo9Nxw7I5448MVXbYFTxV0UQhYcZp3ygszkNFg013+Ir4xnxZ2
 6k5FzNhzyyANaOySr/T41QcwTvDmvZ5CC88i7AK4POqdTCOU+GIWLiftFIr6oxFTnDsE8Rxgh
 O33cnw+AlON1dPVr9IVeJH0CbFCZzcwqWJcXWGUAmRcjctF0GdrLzwkdw6SZV0K2WsDUaou6h
 RYtXCbXKCJ31wBH6HFfMdOO42Vnzw6Pli6jHnKnPLC7nsCaZNohMpqYVUBYNZW16hIIT0VEOv
 mHPEUE8LDFd6q1XLw17uJGG0dX8GkO2ZPDy+16kV+KJraRd46aTtIF+8ECC4jXoQdpahwaGW0
 k+U85BQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Am 17.11.22 um 17:00 schrieb Umang Jain:
> In commit 7967656ffbfa ("coding-style: Clarify the expectations around
> bool") the check to dis-allow bool structure members was removed from
> checkpatch.pl. It promotes bool structure members to store boolean
> values. This enhances code readability.
>
> Umang Jain (3):
>    Revert "staging: mmal-vchiq: Avoid use of bool in structures"
>    vc04_services: mmal-vchiq: Use bool for vchiq_mmal_component.in_use
>    vc04_services: bcm2835-camera: Use bool values for
>      mmal_fmt.remove_padding
>
>   .../bcm2835-camera/bcm2835-camera.c           | 30 +++++++++----------
>   .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 18 +++++------
>   .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  6 ++--
could you please check these changes to be safe? I'm not sure that the 
affected declarations are really internal. I'm afraid this might affect 
firmware or userspace.
>   3 files changed, 27 insertions(+), 27 deletions(-)
>
