Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1DF5F7460
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJGGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJGGwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:52:31 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2172C6C942
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665125548; bh=ju1pJ/daD2F5QWFWspNVkPyTPab6Mhsr8C5SzJfc7DU=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=BBNxRDYvgqfZAIFX1yatY0tEhKUZXaQthkawqx83wMNCPNoxabqBK+8RhRHIAdDrQ
         90Lavj8bKon16vvZJoiCRIt/ilgvQSl38QSM3XaTg4P/im8mE9ljnqfHgDNRjCTD5V
         pD8wx7gPM3oWUeEeavTkTTFGhO8yoLRsA7lWsk3ySMHd+CSsXR5/UeH/z9l/aMaXmd
         SBTGWVO2HNl/vJ9Wtf+rgFEMuLsoSYidouXLyp4oQ1MEtxvXM+WDzvFGvhsd9lBHki
         cJgLY2mGLjp9fRzzlrHDQtDVN4OgB/q3ezBeia8lY3C5h0JRiZmNnOUJfmbhI+Ik23
         69ZCphQLwMIkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyNwk-1pPahk09qW-00yty9 for
 <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:52:28 +0200
Message-ID: <6ee3541aa2a6b61703a567650b8e2cf6e2de3aaf.camel@web.de>
Subject: Re: [git pull] drm for 6.1-rc1
From:   Bert Karwatzki <spasswolf@web.de>
To:     linux-kernel@vger.kernel.org
Date:   Fri, 07 Oct 2022 08:52:26 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0-2 
MIME-Version: 1.0
X-Provags-ID: V03:K1:O3ZYG7m1/JoX3+Q81gly63hKVN5VF7rzoYPDYMDuoJWvBArY03y
 Yt+CfSFRdL2kW0C1tsaeIxIXNbx3eTI4L0mqQMYae2xHf7UmPTMyE9HMZR4H93K8ANMBrUR
 cIDSVasYL1Giz1ggu6rdWmKbpqWIGJTX1xs978repLJrE0vJhzqV3ZkIIQBWLfv983Lrkbm
 cUX8YfLOeNzWypuVzNRkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mp16ZpMR6DY=:NeSSzLKgrfpNoNcNiiixPA
 ooL1ZeNo0KCE6N2l2DZVljlK+41I0tqiZ/7RQAVfmiN7tjIw9d70oZCd2nQW1Iec9VEeqGsB1
 YquaOozcVDFeoft1aCb0+QK7lG0hkVpeMVHRxbWJKcIF38U2n9lHBRgzYvpNj1sXCQ+KV6f9s
 ztjZ/7QUUQQyh/BZ9qSltrehUDOfzuucyiI0H7ILmJfPwrt9w30/0OkXv2PQODbIdeohXmTjN
 iKZPhgDAx1DmGMDa6slVfGX8t1YsX5tGRCLrvlTJP9LjvQLZvJLblLNnU9/kXSo4L9Uv/EmRs
 YwNOcF5JlfM71iGwgNfdel2kYybBljYMAvDc1jL9hZIAp8qGL1M+QbbDVNMit2qPHP1SC+Mbq
 twxK4b+CsFRrnX+6dZifbOSsKERkBC8A4GguhuQ5qjCTy1pBoHfdia49aH9zdof0YgQbB7SyC
 mgyH5MKteSR2Fwl6lCUk9C4+avgAXfEYNZDYovXla5GSob2p0jNYuhuShVRlV6EMlz+eDbyYn
 04r1kHzI+0p1QNVPHWcsp4peUs1H6xFrroBm0WyJG2AHvT3nU5+ORk1/2SfSLlCFGZsdxXATJ
 R29h4sFz3qmi1ZXn0/1bpDvnQzLTUBRQkvJlNriw/GuI5qXiMhbfNfEaVzU2wI5fD4I2Wu9H5
 t94qKBC9OLQnBcji8XWnXw/tIz3HpVR8ZUHhhqeGc2ztfJB8upmxMvvlGd1kmNRg9jCV2bdtW
 EKhIjAL5FOsWx9L6MlZA5m69GuJpYip7UhJuFTg4AEEQOUjHbYQ6ZpF+DqACnGOrnvkbIXM3d
 8d/nxpYDv5zfONVIR2efLMocs6mUX/Pq8/jGfiWubLdEwNR+c9JDHPe7BUsLIWnOxGoso78dB
 vVv1WbZTVk9yMftZtMuWBDquS0XBO/+kkBEkj4MyiAXIxIc1isFFSfAHD5TTnU/Vh6tZi4v6p
 NcRVYMZ3CFAS76Hwjx3upte4hp9Pz5NxcnIXoJUpsbRh0pcPUPXprsGb4dHXmlbuPQn4updpX
 GIrrOrZzSRnkkeBc0Hx33bjff4O9e+D/VK+MSFdYeodEtvR/vBneyHMCAkrQGIBcozk/8rKNB
 +FcNahbAqlU9c2C3OmTTBvv+I4xbpjfJaGFOZ2JKd/Q8l58/QYyuilz1IGuWRkrK0VRy1nJkK
 /eYHqQ+nhIWqoary97DdCukiOgR2esxoD52tLBIW4SQxQBSHWtJXzR6RQ/QMwiJXpqaQeGbjj
 qdkiFzn7eHD1qHNOM3fGuaYhE3GM66KPLM1gMA3paNnraU4FxgUVBE/9eDvO715+1qKgFGIoe
 hDeYFUbC0hqIrYld2GRrrowGB7lz4tt6/FRi3CmGaNV99wOxUvSn0jGvYp6uPuqPOYCG1yqnA
 EAddgkpjm5MrUzvyPZYlKR/loo1BI75KLHGjdlo5TGzjMEQkvE4+DYaBn6TTLPvbjIXzrKS+F
 G/BW7pp/y1n8hNhi7XN8w/BCFZxZsxECAvs5lq+0Kr63LEGWpt5Ac/v36X8K5DF1tCigZozIA
 ZQs4Aqk7D8VreT2ENNGmbdzzuUR4oAnOAfW+IZ94Y9tRF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's also this issue with the drm scheduler. Going back to checking
the finished fence solves this for me on this device:
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi
23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
https://gitlab.freedesktop.org/drm/amd/-/issues/2179

