Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF45734B99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFSGMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSGMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:12:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD983;
        Sun, 18 Jun 2023 23:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687155119; x=1687759919; i=deller@gmx.de;
 bh=qXHv99deYLTD2kNmmjlNL7L1IAyhuZLLm9e6QxYmVUo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dz7QnozsNW1O3khG9qJJBLjQ8zB0r9dYCwVTd6ibDY76A53Y6F0MhJ48alK/0rppaKyczXk
 8IsDmLmbnzMyJAs6KJMaqFPJnK/owrOJJYtjbDser3PuAQvPJ9GtMyVoYc3pwZKG/L+0TYh3t
 Gy8K0m2uwBAYE9uCwzpy7p1KAoWX6zWRl+z4GD+azrXcZ5/IGDi/Zcu96yuc2ETqcevpkf4kF
 D3KXna8W3jknUdrG0d2AFSxN4LJKpyCeZnJ9I8Y4n42mLMKsKT0qZLUmE4b/glkIBXd4ciIyW
 7PQIPZFRxkrxGLl6N63IE9eZYOGx4y7T780oEvj1ca9nCRc0ox4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.204]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsj7-1qP65y1Jnh-00LGQ4; Mon, 19
 Jun 2023 08:11:59 +0200
Message-ID: <b110f9e9-f654-6a43-fa23-ea461d0bb405@gmx.de>
Date:   Mon, 19 Jun 2023 08:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] video/hdmi: Reorder fields in 'struct hdmi_avi_infoframe'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <f5745aeab896f8d4622ff4c3cd0475d9be6bafd8.1687121400.git.christophe.jaillet@wanadoo.fr>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <f5745aeab896f8d4622ff4c3cd0475d9be6bafd8.1687121400.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:THrzSc5kYreNWwNp0T/jefNTCwcF33SLXJ+j9b2pW45wVFGRWgL
 hNdphyJpdlFurvY8hcX4BZEg37Ds/QIMUKY+Hxfd2DVbelBjaFS6F3DtYNBkddEA/kLlj91
 P4Zs/Wu/2qCH5tLvNCMM+Rc3kejbIOSIMohJO6sqcHyve8f+MrWtraPkv/H+Dr7miirMlQ2
 Czm+a1ET/s0IzU+uMfpHQ==
UI-OutboundReport: notjunk:1;M01:P0:yOoWD3U3y0Q=;PT/Ri5PRJRd8WF6+tc3vfJyQFgG
 zecaWq3Yve88tWuqFi8piFjjE0RBwnZWQS5ymAJV/9FIbwLFrzoU3Zl/GLq1hyqJNKiF+MdAk
 8ADoHeqYe2D/LtP+EPOJbQdGUkMumMSVj5pRb/rGSMpZRocDa0zpVtUHNM8iGrs2pasGWAysv
 6QJ12e00x85HcWSZE8mCCtJ+t8J72Wo4X/OWHQuFQp0lge36SahvaJopbos1ABK5o5bU4hs6U
 U3/amuoJzM6kNpdXo6iOnKFJxIseG0LTpvO1+MjuCbOMOvS8LUSTLRY8eYmG4tIwiyD0Lw/Jx
 Er38oWAi0fhCRQhZbvp+cdDsvNL7xcmV2uGXmvLieus8LKNHyT6fq3C6TcRc/aLpYa4hh6Zhl
 fa85g33Y+w8J/baLdtcioiTrjkxn0GM9+VgYrL3pC4dVLxp9HRWm6yzBK92+mlwSKSZdOip7e
 WTBpEooqv4dONkfMP0jkAM/bvQ+qUEUFdhOcafH2Imfgz2hYMSW1U1VpX/zKMFfMWAgfYrY/j
 QL6w83Pa74rg9/Zg6Yd+8jlSsrmr7gEFaRbtw9oxQ+N9D4tIuVYGJx68mJYNecSRC7NHN2DR4
 TMKeMv30lGIjvnHm9bHrfB7la7PKjMTPXxzac4w/7clDbBtF2+fWnlpa9CKMNy6csK6m/k8Ox
 LLcaiJdC6zRqkBEv9meKtE64GMYqD2Q8z+pIHh7HGBpqW0CywficHn+g1FSBM++HWMKxjzBHw
 0S0zumQ7BZymJk9UgE3Z145Y1fYL5nemT2rLY3bKbyWVu+wHj8kv9U4JczXDMrAwFS9QKrKEw
 z3LVr28gJIUbgmp7NotnUYWxTFHHSJLoPE4PAF6my8XjT5dldFRNkgO1lgd4GaIpssoCrYoci
 npQpxvDL+B0LV+BIciUOAzPvewzXuZBdn+fpdX7Mno/K5HtLKk5s32rNCWxGo/norDxgijeW2
 4GTvkQ==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 22:52, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce hole and avoid paddi=
ng.
> On x86_64, this shrinks the size of 'struct hdmi_avi_infoframe'
> from 68 to 60 bytes.
>
> It saves a few bytes of memory and is more cache-line friendly.
>
> This also reduces the union hdmi_infoframe the same way.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

applied.

Thanks!
Helge


> ---
> Using pahole
>
> Before:
> =3D=3D=3D=3D=3D=3D
> struct hdmi_avi_infoframe {
> 	enum hdmi_infoframe_type   type;                 /*     0     4 */
> 	unsigned char              version;              /*     4     1 */
> 	unsigned char              length;               /*     5     1 */
>
> 	/* XXX 2 bytes hole, try to pack */
>
> 	enum hdmi_colorspace       colorspace;           /*     8     4 */
> 	enum hdmi_scan_mode        scan_mode;            /*    12     4 */
> 	enum hdmi_colorimetry      colorimetry;          /*    16     4 */
> 	enum hdmi_picture_aspect   picture_aspect;       /*    20     4 */
> 	enum hdmi_active_aspect    active_aspect;        /*    24     4 */
> 	bool                       itc;                  /*    28     1 */
>
> 	/* XXX 3 bytes hole, try to pack */
>
> 	enum hdmi_extended_colorimetry extended_colorimetry; /*    32     4 */
> 	enum hdmi_quantization_range quantization_range; /*    36     4 */
> 	enum hdmi_nups             nups;                 /*    40     4 */
> 	unsigned char              video_code;           /*    44     1 */
>
> 	/* XXX 3 bytes hole, try to pack */
>
> 	enum hdmi_ycc_quantization_range ycc_quantization_range; /*    48     4=
 */
> 	enum hdmi_content_type     content_type;         /*    52     4 */
> 	unsigned char              pixel_repeat;         /*    56     1 */
>
> 	/* XXX 1 byte hole, try to pack */
>
> 	short unsigned int         top_bar;              /*    58     2 */
> 	short unsigned int         bottom_bar;           /*    60     2 */
> 	short unsigned int         left_bar;             /*    62     2 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	short unsigned int         right_bar;            /*    64     2 */
>
> 	/* size: 68, cachelines: 2, members: 20 */
> 	/* sum members: 57, holes: 4, sum holes: 9 */
> 	/* padding: 2 */
> 	/* last cacheline: 4 bytes */
> };
>
>
> After:
> =3D=3D=3D=3D=3D
> struct hdmi_avi_infoframe {
> 	enum hdmi_infoframe_type   type;                 /*     0     4 */
> 	unsigned char              version;              /*     4     1 */
> 	unsigned char              length;               /*     5     1 */
> 	bool                       itc;                  /*     6     1 */
> 	unsigned char              pixel_repeat;         /*     7     1 */
> 	enum hdmi_colorspace       colorspace;           /*     8     4 */
> 	enum hdmi_scan_mode        scan_mode;            /*    12     4 */
> 	enum hdmi_colorimetry      colorimetry;          /*    16     4 */
> 	enum hdmi_picture_aspect   picture_aspect;       /*    20     4 */
> 	enum hdmi_active_aspect    active_aspect;        /*    24     4 */
> 	enum hdmi_extended_colorimetry extended_colorimetry; /*    28     4 */
> 	enum hdmi_quantization_range quantization_range; /*    32     4 */
> 	enum hdmi_nups             nups;                 /*    36     4 */
> 	unsigned char              video_code;           /*    40     1 */
>
> 	/* XXX 3 bytes hole, try to pack */
>
> 	enum hdmi_ycc_quantization_range ycc_quantization_range; /*    44     4=
 */
> 	enum hdmi_content_type     content_type;         /*    48     4 */
> 	short unsigned int         top_bar;              /*    52     2 */
> 	short unsigned int         bottom_bar;           /*    54     2 */
> 	short unsigned int         left_bar;             /*    56     2 */
> 	short unsigned int         right_bar;            /*    58     2 */
>
> 	/* size: 60, cachelines: 1, members: 20 */
> 	/* sum members: 57, holes: 1, sum holes: 3 */
> 	/* last cacheline: 60 bytes */
> };
> ---
>   include/linux/hdmi.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index 2f4dcc8d060e..3bb87bf6bc65 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -170,19 +170,19 @@ struct hdmi_avi_infoframe {
>   	enum hdmi_infoframe_type type;
>   	unsigned char version;
>   	unsigned char length;
> +	bool itc;
> +	unsigned char pixel_repeat;
>   	enum hdmi_colorspace colorspace;
>   	enum hdmi_scan_mode scan_mode;
>   	enum hdmi_colorimetry colorimetry;
>   	enum hdmi_picture_aspect picture_aspect;
>   	enum hdmi_active_aspect active_aspect;
> -	bool itc;
>   	enum hdmi_extended_colorimetry extended_colorimetry;
>   	enum hdmi_quantization_range quantization_range;
>   	enum hdmi_nups nups;
>   	unsigned char video_code;
>   	enum hdmi_ycc_quantization_range ycc_quantization_range;
>   	enum hdmi_content_type content_type;
> -	unsigned char pixel_repeat;
>   	unsigned short top_bar;
>   	unsigned short bottom_bar;
>   	unsigned short left_bar;

